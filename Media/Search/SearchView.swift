//
//  SearchView.swift
//  Media
//
//  Created by 민지은 on 2024/02/03.
//

import UIKit

class SearchView: BaseView {

    let searchBar = UISearchBar()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    
    var resultList: [TV] = []
    
    override func configureHierarchy() {
        addSubview(searchBar)
        addSubview(collectionView)
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        searchBar.barStyle = .black
        searchBar.placeholder = "시청하고싶은 콘텐츠를 입력하세요"
        collectionView.backgroundColor = .clear
        
        collectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: "Poster")
    }
    
    
    func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 20) / 3, height: 180)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.scrollDirection = .vertical

        return layout
        
    }

}

#Preview {
    SearchViewController()
}
