//
//  EpisodeViewController.swift
//  Media
//
//  Created by 민지은 on 2024/01/31.
//

import UIKit
import Kingfisher

class EpisodeViewController: UIViewController {
    
    let mainView = EpisodeView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPink
        
        mainView.castingCollectionView.delegate = self
        mainView.castingCollectionView.dataSource = self
        mainView.episodeTableView.delegate = self
        mainView.episodeTableView.dataSource = self
        
        let group = DispatchGroup()
        
        group.enter()
        TVAPIManager.shared.getCastAPI(api: .cast(code: mainView.dramaCode)) { cast in
            self.mainView.castList = cast
            group.leave()
        }
        
        group.enter()
        TVAPIManager.shared.getTVAPI(api: .recommand(code: mainView.dramaCode)) { tv in
            self.mainView.recommandList = tv
            group.leave()
        }
        
        group.enter()
        TVAPIManager.shared.getDramaAPI(api: .detail(code: mainView.dramaCode)) { drama in
            self.mainView.dramaList = drama
            group.leave()
        }
        
        
        group.notify(queue: .main) {
            print("⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️")
            self.mainView.configureView()
            self.mainView.castingCollectionView.reloadData()
            self.mainView.episodeTableView.reloadData()
        }

    }
    


}

extension EpisodeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainView.dramaList.seasons.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row ==  mainView.dramaList.seasons.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecommandTableViewCell", for: indexPath) as! RecommandTableViewCell
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            cell.collectionView.register(CastingCollectionViewCell.self, forCellWithReuseIdentifier: "Casting")
            cell.collectionView.reloadData()
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeTableViewCell", for: indexPath) as! EpisodeTableViewCell
            
            cell.episodeTitleLabel.text = "\(mainView.dramaList.seasons[indexPath.row].name)"
            
            if let item = mainView.dramaList.seasons[indexPath.row].poster_path {
                cell.episodeImage.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(item)"))
                cell.episodeImage.contentMode = .scaleToFill
            } else {
                cell.episodeImage.image = UIImage(systemName: "play.rectangle")
                cell.episodeImage.contentMode = .scaleAspectFit
                cell.episodeImage.tintColor = .darkGray
            }

            cell.overViewLabel.text = "\(mainView.dramaList.seasons[indexPath.row].overview ?? "")"
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.row != mainView.dramaList.seasons.count {
            
            let vc = EpisodeDetailViewController()
            
            vc.mainView.id = self.mainView.dramaCode
            vc.mainView.season = self.mainView.dramaList.seasons[indexPath.row].season_number
            
            present(vc, animated: true)
        }
    }
    
    
}

extension EpisodeViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if mainView.castingCollectionView == collectionView {
            if mainView.castList.cast.count > 6 {
                return 6
            } else {
                return mainView.castList.cast.count
            }
        } else {
            return mainView.recommandList.results.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if mainView.castingCollectionView == collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Casting", for: indexPath) as! CastingCollectionViewCell
            
            if let item = mainView.castList.cast[indexPath.row].profile_path {
                cell.personImage.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(item)"))
                cell.personImage.contentMode = .scaleAspectFill
            } else {
                cell.personImage.image = UIImage(systemName: "person.fill")
                cell.personImage.contentMode = .scaleToFill
                cell.personImage.tintColor = .darkGray
            }
            
            cell.nameLabel.text = "\(mainView.castList.cast[indexPath.row].name)"
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Casting", for: indexPath) as! CastingCollectionViewCell
            
            if let item = mainView.recommandList.results[indexPath.row].poster_path {
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if mainView.castingCollectionView != collectionView {
            let vc = EpisodeViewController()
            
            vc.mainView.dramaCode = mainView.recommandList.results[indexPath.row].id
            present(vc, animated: true)
        }
        
    }

}

#Preview {
    EpisodeViewController()
}
