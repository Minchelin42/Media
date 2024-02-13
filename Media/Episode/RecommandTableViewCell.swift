//
//  RecommandTableViewCell.swift
//  Media
//
//  Created by 민지은 on 2024/01/31.
//

import UIKit

final class RecommandTableViewCell: UITableViewCell {

    let titleLabel = PosterTextLabel()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    private func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
    }
    
    private func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(10)
            make.leading.equalTo(contentView).offset(10)
            make.height.equalTo(15)
        }

        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(contentView).inset(5)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
    }
    
    private func configureView() {
        titleLabel.text = "비슷한 컨텐츠"
        collectionView.backgroundColor = .clear
    }
    
    private func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 90, height: 110)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.scrollDirection = .horizontal
        
        return layout
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


#Preview {
    EpisodeViewController()
}
