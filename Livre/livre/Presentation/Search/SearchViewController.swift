//
//  DetailViewController.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/19.
//

import UIKit
import RxSwift
import Lottie

class SearchViewController: BaseViewController {
    let homeIcon = HomeIcon()
    let searchField = SearchField()
    let bookCardField = BookCardCollectionField(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.35))
    let emptyLabel = UILabel()
    let backPageButton = UIButton()
    let nextPageButton = UIButton()
    let recentSearchTable = UITableView()
    let blogField = BlogField()
        
    private let disposeBag = DisposeBag()
    var vm: SearchViewModel = SearchViewModel()
    var initSearchText = ""
    var recentSearchList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        bindViewModel()
        vm.requestBookItems(value: initSearchText)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        homeIcon.startAnimation()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        homeIcon.startAnimation()
    }
    
    private func setupView() {
        setupBackgroundImage()
        setupHomeIcon()
        setupSearchField()
        setupBookCardCollectionField()
        setupEmptyLabel()
        setupBackPageButton()
        setupNextPageButton()
        setupRecentSearchTable()
        setupBlogField()
    }
    
    private func bindViewModel() {
        searchField.textfield.rx.text.orEmpty
            .bind(to: vm.input.searchWord)
            .disposed(by: disposeBag)
        
        searchField.button.rx.tap
            .bind(to: vm.input.searchButton)
            .disposed(by: disposeBag)
        
        vm.output.booksResult.subscribe(onNext: { [weak self] items in
            guard let self = self else { return }
            if items.count == 0 {
                self.emptyLabel.isHidden = false
                self.blogField.setTableViewItem(items: [])
                self.showToast(view: self.view, message: "관련정보를 찾을 수 없습니다.")
            } else {
                self.emptyLabel.isHidden = true
                self.vm.updatePoint(value: self.searchField.getTextFromTextField())
                self.vm.requestBlogItems(value: "책 \(self.searchField.getTextFromTextField())")
            }
            self.bookCardField.setBookItems(items: items)
        }).disposed(by: disposeBag)
        
        vm.output.blogsResult.subscribe(onNext: { [weak self] item in
            self?.blogField.setTableViewItem(items: item)
        }).disposed(by: disposeBag)
        
        vm.output.recentSearchedText.subscribe(onNext: { [weak self] text in
            guard let self = self else { return }
            if self.recentSearchList.count == 5 { self.recentSearchList.removeFirst() }
            self.recentSearchList.append(text)
        }).disposed(by: disposeBag)
    }
    
    // MARK: click event
    @objc func clickHomeIcon(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func clickSearchButton(_ sender: UIButton) {
        self.view.endEditing(true)
        if bookCardField.books.count == 0 { return }
        bookCardField.moveToFirstPage()
    }
    
    @objc func clickBackButton(_ sender: UIButton) {
        bookCardField.moveToPrePage()
    }

    @objc func clickNextButton(_ sender: UIButton) {
        bookCardField.moveToNextPage()
    }
    
    @objc func moveToBlogListViewController(_ sender: UIButton) {
        if searchField.getTextFromTextField().isEmpty {
            self.showToast(view: self.view, message: "검색어를 입력해주세요")
            return
        }
        let nextVC = BlogViewController()
        nextVC.word = "책 \(searchField.getTextFromTextField())"
        self.present(nextVC, animated: true, completion: nil)
    }

}
