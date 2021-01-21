//
//  DetailViewController.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/19.
//

import UIKit
import RxSwift
import Lottie

class DetailViewController: BaseViewController {
    let homeIcon = HomeIcon()
    let searchField = SearchField()
        .then {
            $0.backgroundColor = UIColor(named: "pale_gray")
            $0.setRoundedRectangle()
        }
    let scrollView = UIScrollView()
    let scrollContentsView = UIView()
    let animationOnBCF = AnimationView(name: "splash-icon")
        .then {
            $0.loopMode = .loop
            $0.contentMode = .scaleAspectFit
        }
    let bookCollectionField = BookCollectionField()
    let backPageButton = UIButton()
        .then {
            $0.setImage(UIImage(named: "arrow_left"), for: .normal)
        }
    let nextPageButton = UIButton()
        .then {
            $0.setImage(UIImage(named: "arrow_right"), for: .normal)
        }
    let blogField = BlogField()
    let newsField = NewsField()
    
    let disposeBag = DisposeBag()
    let vm = DetailViewModel()
    var initSearchText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        bindViewModel()
        vm.requestAllSearchData(value: initSearchText)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startAnimation()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        startAnimation()
    }
    
    func startAnimation() {
        homeIcon.startAnimation()
        if !animationOnBCF.isAnimationPlaying { animationOnBCF.play() }
    }
    
    private func setupView() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        setupBackgroundImage()
        setupHomeIcon()
        setupSearchField()
        setupBookCollectionField()
        setupBackPageButton()
        setupNextPageButton()
        setupBlogField()
        setupNewsField()
        setupContentsView()
        setupScrollView()
    }
    
    private func bindViewModel() {
        searchField.textfield.rx.text.orEmpty
            .bind(to: vm.input.searchWord)
            .disposed(by: disposeBag)
        
        searchField.button.rx.tap
            .bind(to: vm.input.searchButton)
            .disposed(by: disposeBag)
        
        vm.output.booksResult.subscribe(onNext: { [weak self] items in
            self?.bookCollectionField.setBookItems(items: items)
        }).disposed(by: disposeBag)
        
        vm.output.blogsResult.subscribe(onNext: { [weak self] items in
            self?.blogField.setTableViewItem(items: items)
        }).disposed(by: disposeBag)
        
        vm.output.newsResult.subscribe(onNext: { [weak self] items in
            self?.newsField.setTableViewItem(items: items)
        }).disposed(by: disposeBag)
    }
    
    @objc func clickHomeIcon(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func clickSearchButton(_ sender: UIButton) {
        self.view.endEditing(true)
        bookCollectionField.moveToFirstPage()
        blogField.moveToFirstRow()
        newsField.moveToFirstRow()
    }
    
    @objc func clickBackButton(_ sender: UIButton) {
        bookCollectionField.moveToPrePage()
    }
    
    @objc func clickNextButton(_ sender: UIButton) {
        bookCollectionField.moveToNextPage()
    }

}

// MARK: +Delegate
extension DetailViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
        startAnimation()
    }
}

extension DetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
