//
//  MainViewControllerComponent.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/19.
//

import UIKit

extension MainViewController {    
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
    
    func setupBasicLabel() {
        basicLabel.text = "책을 검색해보세요!\n검색할수록 더 많은 포인트가 지급됩니다!"
        basicLabel.numberOfLines = 0
        basicLabel.textAlignment = .center
        basicLabel.textColor = UIColor(named: "pale_gray")
        self.view.addSubview(basicLabel)
        
        basicLabel.translatesAutoresizingMaskIntoConstraints = false
        basicLabel.topAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 20).isActive = true
        basicLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    func setupRewardView() {
        self.view.addSubview(rewardView)
        
        rewardView.translatesAutoresizingMaskIntoConstraints = false
        rewardView.topAnchor.constraint(equalTo: basicLabel.bottomAnchor, constant: 30).isActive = true
        rewardView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: spaceForLeftRight + 10).isActive = true
        rewardView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: spaceForLeftRight * -1 - 10).isActive = true
    }
    
    func setupStartLevelLabel() {
        startLevelLabel.text = "lv."
        startLevelLabel.font = UIFont.systemFont(ofSize: 14)
        startLevelLabel.textColor = UIColor(named: "light_gray_blue")
        self.view.addSubview(startLevelLabel)
        
        startLevelLabel.translatesAutoresizingMaskIntoConstraints = false
        startLevelLabel.topAnchor.constraint(equalTo: rewardView.bottomAnchor, constant: 4).isActive = true
        startLevelLabel.centerXAnchor.constraint(equalTo: rewardView.leadingAnchor).isActive = true
    }
    
    func setupEndLevelLabel() {
        endLevelLabel.text = "lv."
        endLevelLabel.font = UIFont.systemFont(ofSize: 14)
        endLevelLabel.textColor = UIColor(named: "light_gray_blue")
        self.view.addSubview(endLevelLabel)
        
        endLevelLabel.translatesAutoresizingMaskIntoConstraints = false
        endLevelLabel.topAnchor.constraint(equalTo: rewardView.bottomAnchor, constant: 4).isActive = true
        endLevelLabel.centerXAnchor.constraint(equalTo: rewardView.trailingAnchor).isActive = true
    }
    
    func setupPointLabel() {
        pointLabel.text = "-/-"
        pointLabel.font = UIFont.systemFont(ofSize: 16)
        pointLabel.textColor = UIColor(named: "pale_gray")
        self.view.addSubview(pointLabel)
        
        pointLabel.translatesAutoresizingMaskIntoConstraints = false
        pointLabel.topAnchor.constraint(equalTo: rewardView.bottomAnchor, constant: 30).isActive = true
        pointLabel.centerXAnchor.constraint(equalTo: rewardView.centerXAnchor).isActive = true
    }
}