//
//  DetailViewModel.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/19.
//

import RxSwift
import RxCocoa

class DetailViewModel {
    let input = Input()
    let output = Output()
    private let disposeBag = DisposeBag()
    
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
    
    init() {
        input.searchButton.withLatestFrom(input.searchWord)
            .filter { !$0.isEmpty }
            .subscribe(onNext: { [weak self] text in
                self?.requestAllSearchData(value: text)
                self?.updatePoint(value: text)
            }).disposed(by: disposeBag)
    }
    
    func requestAllSearchData(value: String) {
        requestBookItems(value: value)
        requestBlogItems(value: value)
        requestNewsItems(value: value)
    }
    
    private func requestBookItems(value: String) {
        requestBookSearch(query: value, relay: output.booksResult)
    }
    
    private func requestBlogItems(value: String) {
        requestBlogs(query: value, relay: output.blogsResult)
    }
    
    private func requestNewsItems(value: String) {
        requestNews(query: value, relay: output.newsResult)
    }
    
    private func updatePoint(value: String) {
        RewardConfig.addPoint(point: Float(value.count * 2))
        output.pointResult.accept(getPointString())
    }
    
    private func getPointString() -> String {
        return "lv \(RewardConfig.getCurrentLevel()). \(Int(RewardConfig.getCurrentPoint()))/\(Int(RewardConfig.getPointList()![RewardConfig.getCurrentLevel()]))"
    }
}