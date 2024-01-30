//
//  InfoTextLabel.swift
//  Media
//
//  Created by 민지은 on 2024/01/31.
//

import UIKit

class InfoTextLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .red
        clipsToBounds = true
        layer.cornerRadius = 3
        textColor = .white
        font = .systemFont(ofSize: 13, weight: .semibold)
        textAlignment = .center
        numberOfLines = 0

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
