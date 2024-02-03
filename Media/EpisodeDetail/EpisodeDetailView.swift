//
//  EpisodeDetailView.swift
//  Media
//
//  Created by 민지은 on 2024/02/04.
//

import UIKit
import Kingfisher

class EpisodeDetailView: BaseView {
    
//    let name: String
//    let overview: String?
//    let poster_path: String?
//    let id: Int
//    let season_number: Int
    
    let dramaPoster = UIImageView()
    let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        return view
    } ()
    
    let seasonTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textAlignment = .left
        label.textColor = .white
        return label
    } ()
    
    let seasonOverView = OverViewLabel()
    
    let tableView = UITableView()
    let seasonInfoView = UIView()
    
    var episode: EpisodeDetailModel = EpisodeDetailModel(name: "", overview: "", episodes: [], poster_path: "")
    
    var id = 19885
    var season = 2
    
    override func configureHierarchy() {
        addSubview(dramaPoster)
        addSubview(overlayView)
        addSubview(seasonTitle)
        addSubview(seasonOverView)
        addSubview(tableView)
    }
    
    override func configureLayout() {
        dramaPoster.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(320)
        }
        
        overlayView.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.horizontalEdges.bottom.equalTo(dramaPoster)
        }
        
        seasonTitle.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(15)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(15)
        }
        
        seasonOverView.snp.makeConstraints { make in
            make.top.equalTo(seasonTitle.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(15)
            make.height.lessThanOrEqualTo(250)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(overlayView.snp.bottom)
            make.bottom.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        
    }
    
    override func configureView() {
        
        if let image = episode.poster_path {
            dramaPoster.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(image)"))
        } else {
            dramaPoster.backgroundColor = .black
        }
        dramaPoster.contentMode = .scaleAspectFill
        seasonInfoView.backgroundColor = .white
        
        tableView.register(EpisodeDetailTableViewCell.self, forCellReuseIdentifier: "EpisodeDetailTableViewCell")
        
        tableView.backgroundColor = .black
        
        seasonTitle.text = "\(episode.name)"
        seasonOverView.text = "\(episode.overview)"
        
        
    }
    
}

#Preview {
    EpisodeDetailViewController()
}
