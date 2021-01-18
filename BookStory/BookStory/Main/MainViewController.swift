//
//  ViewController.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/17.
//

import UIKit
import Lottie

class MainViewController: UIViewController {
    let animationView = AnimationView(name: "main-book")
    let searchFieldView = SearchField()
    
    private let spaceForLeftRight: CGFloat = 25

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }

    func setupView() {
        self.view.setGradient(colors: [UIColor(named: "gradient_start")!.cgColor, UIColor(named: "gradient_end")!.cgColor])
        
        setupAnimationView()
        setupSearchFieldView()
    }
    
    func setupAnimationView() {
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        self.view.addSubview(animationView) // 애니메이션뷰를 메인뷰에 추가
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.widthAnchor.constraint(equalToConstant: 170).isActive = true
        animationView.heightAnchor.constraint(equalToConstant: 170).isActive = true
        animationView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        animationView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.frame.height * 0.15).isActive = true
        animationView.play() // 애미메이션뷰 실행
    }
    
    func setupSearchFieldView() {
        searchFieldView.setRoundedRectangle()
        searchFieldView.backgroundColor = UIColor(named: "pale_gray")
        self.view.addSubview(searchFieldView)
        
        searchFieldView.translatesAutoresizingMaskIntoConstraints = false
        searchFieldView.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 40).isActive = true
        searchFieldView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: spaceForLeftRight).isActive = true
        searchFieldView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: spaceForLeftRight * -1).isActive = true
    }

}

