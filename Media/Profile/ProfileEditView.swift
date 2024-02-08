//
//  ProfileEditView.swift
//  Media
//
//  Created by 민지은 on 2024/02/09.
//

import UIKit

class ProfileEditView: BaseView {

    let titleLabel = UILabel()
    let inputTextField = UITextField()
    
    
    override func configureHierarchy() {
        addSubview(titleLabel)
        addSubview(inputTextField)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(70)
            make.height.equalTo(20)
        }
        
        inputTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(45)
        }
    }
    
    override func configureView() {
        titleLabel.text = "이름"
        titleLabel.textColor = .gray
        titleLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        
        inputTextField.placeholder = "내용을 입력해주세요"
        inputTextField.font = .systemFont(ofSize: 15, weight: .medium)
        inputTextField.textColor = .white
        inputTextField.backgroundColor = .black

        inputTextField.clearButtonWithImage(UIImage(systemName: "x.circle.fill")!)
    }

}
