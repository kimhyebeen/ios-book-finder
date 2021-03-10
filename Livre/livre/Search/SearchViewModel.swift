//
//  DetailViewModel.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/19.
//

import RxSwift
import RxCocoa

class SearchViewModel {
    let input = Input()
    let output = Output()
    private let disposeBag = DisposeBag()
    
    var currentWord = ""
    
    struct Input {
        let searchWord = PublishSubject<String>()
        let searchButton = PublishSubject<Void>()
    }
    
    struct Output {
        let booksResult = PublishRelay<[SimpleBookItem]>()
        let blogsResult = PublishRelay<[BlogItem]>()
        let newsResult = PublishRelay<[NewsItem]>()
        let pointResult = BehaviorRelay<String>(value: "lv \(RewardConfig.getCurrentLevel()). \(Int(RewardConfig.getCurrentPoint()))/\(Int(RewardConfig.getPointList()![RewardConfig.getCurrentLevel()]))")
    }
    
    init(value: String) {
        currentWord = value
        input.searchButton.withLatestFrom(input.searchWord)
            .filter { !$0.isEmpty }
            .subscribe(onNext: { [weak self] text in
                self?.requestAllSearchData(value: text)
            }).disposed(by: disposeBag)
    }
    
    func requestAllSearchData(value: String) {
        currentWord = value
        requestBookItems(value: value)
        requestBlogItems(value: value)
        requestNewsItems(value: value)
        updatePoint(value: value)
    }
    
    private func requestBookItems(value: String) {
        requestBookSearch(query: value).subscribe(onNext: { [weak self] item in
            self?.output.booksResult.accept(item)
        }).disposed(by: disposeBag)
    }
    
    private func requestBlogItems(value: String) {
        requestBlogs(query: value).subscribe(onNext: { [weak self] items in
            self?.output.blogsResult.accept(items)
        }).disposed(by: disposeBag)
    }
    
    private func requestNewsItems(value: String) {
        requestNews(query: value).subscribe(onNext: { [weak self] items in
            self?.output.newsResult.accept(items)
        }).disposed(by: disposeBag)
    }
    
    private func updatePoint(value: String) {
        RewardConfig.addPoint(point: Float(value.count * 2))
        output.pointResult.accept(getPointString())
    }
    
    private func getPointString() -> String {
        return "lv \(RewardConfig.getCurrentLevel()). \(Int(RewardConfig.getCurrentPoint()))/\(Int(RewardConfig.getPointList()![RewardConfig.getCurrentLevel()]))"
    }
}
