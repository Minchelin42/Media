//
//  PosterImageView.swift
//  Media
//
//  Created by 민지은 on 2024/01/30.
//

import UIKit

class PosterImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        contentMode = .scaleAspectFill
        clipsToBounds = true
        layer.cornerRadius = 5
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
