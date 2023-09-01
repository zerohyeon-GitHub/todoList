//
//  HomeViewController.swift
//  Todo_myDreams
//
//  Created by t2023-m0059 on 2023/08/23.
//

//3. 홈화면에 이미지 URL을 활용하여 `UIImageView`에 표시해주기
//    - 이미지 URL: https://spartacodingclub.kr/css/images/scc-og.jpg
//    - 이미지 URL에 있는 이미지를 사용하여 `UIImageView`에 보여주세요.
//    - 주의사항 : UI는 `Main Thread`에서 업데이트 해야합니다.

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    private let homeView = HomeView()
    
//    init(homeView: HomeView) {
//        self.homeView = homeView
//
//        super.init(nibName: nil, bundle: nil)
//
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    
    // MARK: - View Life Cycle
    
//    override func loadView() {
//        view = homeView
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(homeView)
        
        NSLayoutConstraint.activate([
            homeView.topAnchor.constraint(equalTo: view.topAnchor),
            homeView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            homeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        setupNavigationBar()
    }
    
    // MARK: - Helpers
    
    /*
     Navigation bars
     Apple 공식: A navigation bar appears at the top of a window or screen, helping people navigate through a hierarchy of content.
     */
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground() //background는 #ffffff. 즉 white고, shadow는 default때와 똑같이 #0000004c(검정색에 alpha 30%)
        appearance.largeTitleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 30),
            .foregroundColor: UIColor.black
        ]
        // Navigation Bar Title 설정
        let titleName = UILabel()
        titleName.text = "Home View Controller"
        titleName.font = UIFont.boldSystemFont(ofSize: 20)
        titleName.sizeToFit()
        
        navigationItem.titleView = titleName
        
        //        navigationController?.navigationBar.topItem?.titleView = titleName
        
        navigationController?.navigationBar.tintColor = .black // 좌측 back button의 색상이 바뀜
        
        // NavigationController 자체의 title을 URL Session으로 변경
        // navigationController?.navigationBar.topItem?.title = "URL Session"
        // navigationController?.navigationBar.standardAppearance = appearance // standardAppearance: Naviation bar 모양을 조절할 때, (기본 높이의 navigation Bar를 사용할 때 사용.)
        // navigationController?.navigationBar.scrollEdgeAppearance = appearance // Navigation Bar 밑에 줄 표시
        
        //        navigationController?.navigationBar.scrollEdgeAppearance = appearance // Navigation Bar 밑에 줄 표시
        navigationItem.scrollEdgeAppearance = appearance
    }
    
    
    
    
    // MARK: - Actions
    @objc private func backButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func editDetailPage(){
        // page 이동 함수
    }
}


