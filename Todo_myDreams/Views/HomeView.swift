//
//  HomeView.swift
//  Todo_myDreams
//
//  Created by t2023-m0059 on 2023/08/25.
//

import Foundation
import UIKit

class HomeView: UIView {
    // MARK: - Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "URL Image 표시"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.black
        
        label.translatesAutoresizingMaskIntoConstraints = false // translatesAutoresizingMaskIntoConstraints ? 왜 이걸 안하면 표시 가안되는 걸까?
        /*
         translatesAutoresizingMaskIntoConstraints: UIView의 인스턴스 프로퍼티
         Apple 공식 문서 내용 : A Boolean value that determines whether the view’s autoresizing mask is translated into Auto Layout constraints.
         Constraint를 코드로 조정해야할 때 호출하는 역할 (StoryBoard로 View를 추가하게 되면 이는 자동으로 false로 자동 설정
         
         *Autoresizing mask의 경우 view의 크기와 위치를 Full. 가득 채우는 형식으로 지정.
         => 결과적으로 충돌을 일으키지 않고, 크기와 위치를 수정하기 위해 추가 constraint를 추가할 수 없음.
         (하지만 'translatesAutoresizingMaskIntoConstraints = false'를 지정해주면 constraint를 추가할 수 있다.
         */
        
        return label
    }()
    
    private let homeImageView: UIImageView = {
        let imageView = UIImageView()
        let spartImageUrl = URL(string: "https://spartacodingclub.kr/css/images/scc-og.jpg")!
        
        imageView.contentMode = .scaleAspectFit
        imageView.load(url: spartImageUrl)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .white
        
        // self.translatesAutoresizingMaskIntoConstraints = false -> 여기서 self. 란? 메모리에 관련이 될 수 있다. 공부 시 참조
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
        addSubview(homeImageView)
        
        /*
         NSLayoutConstraint(item: , attribute: , relatedBy: , toItem: , attribute: , multiplier: , constant: )
         item: 제약을 지정할 UI
         attribute: 제약을 지정할 UI의 제약 속성
         relatedBy: 제약을 지정할 UI와 제약의 기준이 되는 UI 사이의 관계
         toItem: 제약의 기준이 되는 UI
         attribute: 제약의 기준이 되는 UI의 제약 속성
         multiplier: 제약의 비율
         constraint: 제약의 상수값
         
         Apple 공식: The relationship between two user interface objects that must be satisfied by the constraint-based layout system.
         
         activate(_:): Activates each constraint in the specified array.
         */
        
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            homeImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            homeImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            homeImageView.widthAnchor.constraint(equalToConstant: 300),
            homeImageView.heightAnchor.constraint(equalToConstant: 150),
            //            homeImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            //            homeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 60),
        ])
    }
    
}

extension UIImageView {
    func load(url: URL) {
        //main thread에서 load할 경우 URL 로딩이 길면 화면이 멈춘다.
        //이를 방지하기 위해 다른 thread에서 처리함.
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
