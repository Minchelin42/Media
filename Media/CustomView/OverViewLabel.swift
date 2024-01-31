//
//  OverViewLabel.swift
//  Media
//
//  Created by 민지은 on 2024/01/31.
//

import UIKit

class OverViewLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = .lightGray
        font = .systemFont(ofSize: 13, weight: .medium)
        numberOfLines = 0

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
