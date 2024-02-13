//
//  ProfileTableViewCell.swift
//  Media
//
//  Created by 민지은 on 2024/02/08.
//

import UIKit

final class ProfileTableViewCell: UITableViewCell {

    let titleLabel = UILabel()
    let profileLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    private func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(profileLabel)
    }
    
    private func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(10)
            make.centerY.equalToSuperview()
            make.width.equalTo(70)
            make.height.equalTo(15)
        }
        
        profileLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(-30)
            make.height.equalTo(15)
        }
    }
    
    private func configureView() {
        titleLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        titleLabel.textColor = .lightGray
        
        profileLabel.text = "사용자 이름"
        profileLabel.font = .systemFont(ofSize: 13, weight: .medium)
        profileLabel.textColor = .white
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

#Preview {
    ProfileViewController()
}
