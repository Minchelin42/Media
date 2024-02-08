//
//  ProfileView.swift
//  Media
//
//  Created by 민지은 on 2024/02/08.
//

import UIKit

class ProfileView: BaseView {
    
    let profileImage = UIImageView()
    let imageEditButton = UIButton()
    let profileTableView = UITableView()

    override func configureHierarchy() {
        addSubview(profileImage)
        addSubview(imageEditButton)
        addSubview(profileTableView)
    }
    
    override func configureLayout() {
        profileImage.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.top.equalTo(safeAreaLayoutGuide).offset(50)
            make.centerX.equalTo(safeAreaLayoutGuide)
        }
        
        imageEditButton.snp.makeConstraints { make in
            make.height.equalTo(15)
            make.width.equalTo(120)
            make.top.equalTo(profileImage.snp.bottom).offset(20)
            make.centerX.equalTo(self)
        }
        
        profileTableView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(safeAreaInsets)
            make.top.equalTo(imageEditButton.snp.bottom).offset(20)
        }
    }
    
    override func configureView() {
        profileImage.image = UIImage(systemName: "suit.heart")
        profileImage.backgroundColor = .white
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = 50
        
        profileTableView.backgroundColor = .clear
        profileTableView.rowHeight = 45
        profileTableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: "Profile")
        profileTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        profileTableView.separatorColor = .darkGray
        
        imageEditButton.setTitle("사진 또는 아바타 수정", for: .normal)
        imageEditButton.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
        imageEditButton.setTitleColor(.systemBlue, for: .normal)
    }
    
    
}

#Preview {
    ProfileViewController()
}
