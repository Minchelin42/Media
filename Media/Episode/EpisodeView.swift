//
//  EpisodeView.swift
//  Media
//
//  Created by 민지은 on 2024/02/01.
//

import UIKit

class EpisodeView: BaseView {
    
    let dramaPoster = UIImageView()
    let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        return view
    } ()
    
    let dramaTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textAlignment = .left
        label.textColor = .white
        return label
    } ()
    
    let dramaOverView = OverViewLabel()
    
    lazy var castingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    let episodeTableView = UITableView()
    
    var castList: CastModel = CastModel(cast: [])
    var dramaList: DramaModel = DramaModel(name: "", seasons: [], overview: "", poster_path: "")
    var recommandList: TVModel = TVModel(results: [])
    
    var dramaCode = 19885
    //19885: 셜록, 70123: 신서유기
    
    
    override func configureHierarchy() {
        print("🩷🩷🩷🩷🩷🩷🩷🩷🩷" + #function)
        addSubview(dramaPoster)
        addSubview(overlayView)
        addSubview(dramaTitle)
        addSubview(dramaOverView)
        addSubview(castingCollectionView)
        addSubview(episodeTableView)
    }
    
    override func configureLayout() {
        print("🩷🩷🩷🩷🩷🩷🩷🩷🩷" + #function)
        dramaPoster.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(320)
        }
        
        overlayView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.top.equalTo(self)
        }
        dramaTitle.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(15)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(15)
        }
        
        dramaOverView.snp.makeConstraints { make in
            make.top.equalTo(dramaTitle.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(15)
            make.height.lessThanOrEqualTo(105)
        }
        
        castingCollectionView.snp.makeConstraints { make in
            make.bottom.equalTo(dramaPoster.snp.bottom).inset(20)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(140)
        }
        
        episodeTableView.snp.makeConstraints { make in
            make.top.equalTo(dramaPoster.snp.bottom)
            make.bottom.horizontalEdges.equalTo(self)
        }
    }
    
    
    override func configureView() {
        dramaPoster.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(dramaList.poster_path)"))
        dramaPoster.contentMode = .scaleAspectFill
        
        dramaTitle.text = "\(dramaList.name)"
        
        dramaOverView.text = "\(dramaList.overview)"
        
        castingCollectionView.register(CastingCollectionViewCell.self, forCellWithReuseIdentifier: "Casting")
        castingCollectionView.backgroundColor = .clear

        episodeTableView.rowHeight = 150
        episodeTableView.register(EpisodeTableViewCell.self, forCellReuseIdentifier: "EpisodeTableViewCell")
        episodeTableView.register(RecommandTableViewCell.self, forCellReuseIdentifier: "RecommandTableViewCell")
        episodeTableView.backgroundColor = .black
    }
    
    
    
    func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 4, height: 140)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.scrollDirection = .horizontal

        return layout
        
    }
    
}

#Preview {
    EpisodeViewController()
}
