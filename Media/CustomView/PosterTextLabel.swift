//
//  PosterTextLabel.swift
//  Media
//
//  Created by 민지은 on 2024/01/30.
//

import UIKit

class PosterTextLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        textColor = .white
        font = .systemFont(ofSize: 15, weight: .heavy)
        textAlignment = .center
        numberOfLines = 0

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
