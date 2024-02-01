//
//  MainView.swift
//  Media
//
//  Created by 민지은 on 2024/02/01.
//

import UIKit

class MainView: BaseView {
    
    lazy var topCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    let mainTableView = UITableView()
    
    var posterList: [TVModel] = [
        TVModel(results: []),
        TVModel(results: []),
        TVModel(results: [])
    ]
    
    let listTitle = ["Top Rated List", "Popular List"]
    
    let newTitle = ["새로운 에피소드", "새로운 시리즈", "새로운 작품"]
    
    override func configureHierarchy(){
        addSubview(topCollectionView)
        addSubview(mainTableView)
    }
    
    override func configureLayout(){
        topCollectionView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(250)
        }
        
        mainTableView.snp.makeConstraints { make in
            make.top.equalTo(topCollectionView.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView(){
        topCollectionView.backgroundColor = .clear

        topCollectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: "Poster")
        
        mainTableView.backgroundColor = .clear
        mainTableView.rowHeight = 240
        mainTableView.register(PosterTableViewCell.self, forCellReuseIdentifier: "PosterTableViewCell")
    }

    func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3, height: 230)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal

        return layout
        
    }
    
    
    
    
}
