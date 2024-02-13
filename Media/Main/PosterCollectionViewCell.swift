//
//  PosterCollectionViewCell.swift
//  Media
//
//  Created by 민지은 on 2024/01/30.
//

import UIKit

final class PosterCollectionViewCell: UICollectionViewCell {
    let posterImageView = PosterImageView(frame: .zero)
    let textLabel = RedBackgroundTextLabel()
    let posterNameLabel = PosterTextLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    private func configureHierarchy() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(textLabel)
        contentView.addSubview(posterNameLabel)
    }
    
    private func configureLayout() {
        posterImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        textLabel.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.bottom.horizontalEdges.equalTo(contentView).inset(10)
        }
        
        posterNameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(contentView).offset(25)
            make.horizontalEdges.equalTo(contentView)
            make.height.equalTo(15)
        }
    }
    
    private func configureView() {
        posterImageView.image = UIImage(systemName: "suit.heart")
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
}

#Preview {
    MainViewController()
}
