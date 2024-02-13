//
//  ImageSearchView.swift
//  Media
//
//  Created by 민지은 on 2024/02/13.
//

import UIKit

class ImageSearchView: BaseView {
    
    let searchBar = UISearchBar()
    let searchResultLabel = UILabel()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    
    override func configureHierarchy() {
        addSubview(searchBar)
        addSubview(searchResultLabel)
        addSubview(collectionView)
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
        
        searchResultLabel.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(30)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchResultLabel.snp.bottom)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        searchBar.barTintColor = .black
        searchBar.searchTextField.textColor = .white

        searchResultLabel.textColor = .white
        searchResultLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        searchResultLabel.text = ""
        
        collectionView.backgroundColor = .clear
        collectionView.register(CastingCollectionViewCell.self, forCellWithReuseIdentifier: "Casting")
    }
    
    private func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 20) / 3, height: (UIScreen.main.bounds.width - 20) / 3)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.scrollDirection = .vertical

        return layout
        
    }
    
    
}

#Preview {
    ImageSearchViewController()
}
