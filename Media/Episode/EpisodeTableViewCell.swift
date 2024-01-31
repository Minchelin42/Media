//
//  EpisodeTableViewCell.swift
//  Media
//
//  Created by 민지은 on 2024/01/31.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {

    let episodeImage = PosterImageView(frame: .zero)
    let episodeTitleLabel = PosterTextLabel()
    let overViewLabel = OverViewLabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureHierarchy() {
        contentView.addSubview(episodeImage)
        contentView.addSubview(episodeTitleLabel)
        contentView.addSubview(overViewLabel)
    }
    
    func configureLayout() {
        episodeImage.snp.makeConstraints { make in
            make.verticalEdges.equalTo(contentView).inset(10)
            make.leading.equalTo(contentView).offset(10)
            make.width.equalTo(100)
        }
        
        episodeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(20)
            make.leading.equalTo(episodeImage.snp.trailing).offset(20)
            make.trailing.lessThanOrEqualTo(contentView).inset(15)
            make.height.equalTo(15)
        }
        
        overViewLabel.snp.makeConstraints { make in
            make.top.equalTo(episodeTitleLabel.snp.bottom).offset(10)
            make.leading.equalTo(episodeImage.snp.trailing).offset(20)
            make.trailing.equalTo(contentView).inset(25)
            make.bottom.lessThanOrEqualTo(contentView).inset(10)
            
        }
        
        
    }
    
    func configureView() {
        episodeImage.backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


#Preview {
    EpisodeViewController()
}
