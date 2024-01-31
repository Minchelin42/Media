//
//  EpisodeViewController.swift
//  Media
//
//  Created by 민지은 on 2024/01/31.
//

import UIKit
import Kingfisher

class EpisodeViewController: UIViewController {

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
    
    let dramaCode = "19885"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPink
        
        let group = DispatchGroup()
        
        group.enter()
        TVAPIManager.shared.getCastAPI(APItype: "tv/\(dramaCode)/aggregate_credits") { cast in
            self.castList = cast
            group.leave()
        }
        
        group.enter()
        TVAPIManager.shared.getTVAPI(APItype: "tv/\(dramaCode)/recommendations") { tv in
            self.recommandList = tv
            group.leave()
        }
        
        group.enter()
        TVAPIManager.shared.getDramaAPI(APItype: "tv/\(dramaCode)") { drama in
            self.dramaList = drama
            group.leave()
        }
        
        group.notify(queue: .main) {
            print("⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️")
            self.configureView()
            self.castingCollectionView.reloadData()
            self.episodeTableView.reloadData()
        }
        
        configureHierarchy()
        configureLayout()

        
    }
    
    func configureHierarchy() {
        print("🩷🩷🩷🩷🩷🩷🩷🩷🩷" + #function)
        view.addSubview(dramaPoster)
        dramaPoster.addSubview(overlayView)
        view.addSubview(dramaTitle)
        view.addSubview(dramaOverView)
        view.addSubview(castingCollectionView)
        view.addSubview(episodeTableView)
    }
    
    func configureLayout() {
        print("🩷🩷🩷🩷🩷🩷🩷🩷🩷" + #function)
        dramaPoster.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(320)
        }
        
        overlayView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.top.equalTo(view)
        }
        
        dramaTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(15)
        }
        
        dramaOverView.snp.makeConstraints { make in
            make.top.equalTo(dramaTitle.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.height.lessThanOrEqualTo(110)
        }
        
        castingCollectionView.snp.makeConstraints { make in
            make.top.equalTo(dramaOverView.snp.bottom).offset(20)
            make.bottom.equalTo(dramaPoster.snp.bottom).inset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(140)
        }
        
        episodeTableView.snp.makeConstraints { make in
            make.top.equalTo(dramaPoster.snp.bottom)
            make.bottom.horizontalEdges.equalTo(view)
        }
    }
    
    func configureView() {
        dramaPoster.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(dramaList.poster_path)"))
        dramaPoster.contentMode = .scaleAspectFill
        
        dramaTitle.text = "\(dramaList.name)"
        
        dramaOverView.text = "\(dramaList.overview)"
        
        castingCollectionView.delegate = self
        castingCollectionView.dataSource = self
        castingCollectionView.register(CastingCollectionViewCell.self, forCellWithReuseIdentifier: "Casting")
        castingCollectionView.backgroundColor = .clear
        
        episodeTableView.delegate = self
        episodeTableView.dataSource = self
        episodeTableView.rowHeight = 150
        episodeTableView.register(EpisodeTableViewCell.self, forCellReuseIdentifier: "EpisodeTableViewCell")
        episodeTableView.register(RecommandTableViewCell.self, forCellReuseIdentifier: "RecommandTableViewCell")
        episodeTableView.backgroundColor = .black
        episodeTableView.allowsSelection = false
    }

}

extension EpisodeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dramaList.seasons.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row ==  dramaList.seasons.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecommandTableViewCell", for: indexPath) as! RecommandTableViewCell
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            cell.collectionView.register(CastingCollectionViewCell.self, forCellWithReuseIdentifier: "Casting")
            cell.collectionView.reloadData()
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeTableViewCell", for: indexPath) as! EpisodeTableViewCell
            
            cell.episodeTitleLabel.text = "\(dramaList.seasons[indexPath.row].name)"
            
            if let item = dramaList.seasons[indexPath.row].poster_path {
                cell.episodeImage.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(item)"))
                cell.episodeImage.contentMode = .scaleToFill
            } else {
                cell.episodeImage.image = UIImage(systemName: "play.rectangle")
                cell.episodeImage.contentMode = .scaleAspectFit
                cell.episodeImage.tintColor = .darkGray
            }

            cell.overViewLabel.text = "\(dramaList.seasons[indexPath.row].overview ?? "")"
            
            return cell
        }
    }
    
    
}

extension EpisodeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 4, height: 140)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout.scrollDirection = .horizontal

        return layout
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if castingCollectionView == collectionView {
            if castList.cast.count > 6 {
                return 6
            } else {
                return castList.cast.count
            }
        } else {
            return recommandList.results.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if castingCollectionView == collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Casting", for: indexPath) as! CastingCollectionViewCell
            
            if let item = castList.cast[indexPath.row].profile_path {
                cell.personImage.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(item)"))
                cell.personImage.contentMode = .scaleAspectFill
            } else {
                cell.personImage.image = UIImage(systemName: "person.fill")
                cell.personImage.contentMode = .scaleToFill
                cell.personImage.tintColor = .darkGray
            }
            
            cell.nameLabel.text = "\(castList.cast[indexPath.row].name)"
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Casting", for: indexPath) as! CastingCollectionViewCell
            
            if let item = recommandList.results[indexPath.row].poster_path {
                cell.personImage.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(item)"))
                cell.personImage.contentMode = .scaleToFill
            } else {
                cell.personImage.image = UIImage(systemName: "play.rectangle")
                cell.personImage.contentMode = .scaleAspectFit
                cell.personImage.tintColor = .darkGray
            }
            return cell
        }
    }

}

#Preview {
    EpisodeViewController()
}
