//
//  CastingCollectionViewCell.swift
//  Media
//
//  Created by 민지은 on 2024/01/31.
//

import UIKit

final class CastingCollectionViewCell: UICollectionViewCell {
    
    let personImage = PosterImageView(frame: .zero)
    let nameLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        
        return label
    } ()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureView()
        
    }
    
    private func configureHierarchy() {
        contentView.addSubview(personImage)
        contentView.addSubview(nameLabel)
    }
    
    private func configureLayout() {
        personImage.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        nameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(personImage).inset(10)
            make.height.greaterThanOrEqualTo(15)
            make.centerX.equalTo(personImage)
            make.horizontalEdges.equalTo(personImage).inset(5)
        }
    }

    private func configureView() {
        personImage.backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

#Preview {
    EpisodeViewController()
}
