//
//  MainViewController.swift
//  Media
//
//  Created by 민지은 on 2024/01/30.
//

import UIKit
import Kingfisher
import SnapKit

class MainViewController: UIViewController {

    let mainView = MainView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        
        mainView.topCollectionView.delegate = self
        mainView.topCollectionView.dataSource = self

        mainView.mainTableView.delegate = self
        mainView.mainTableView.dataSource = self
        
        let group = DispatchGroup()
        
        group.enter()      
        TVAPIManager.shared.APIcall(type: TVModel.self, api: .trending) { tv in
            self.mainView.posterList[0] = tv
            group.leave()
        }
        
        
        
        
        group.enter()
        TVAPIManager.shared.APIcall(type: TVModel.self, api: .top_rated) { tv in
            self.mainView.posterList[1] = tv
            group.leave()
        }
        
        
        group.enter()
        TVAPIManager.shared.APIcall(type: TVModel.self, api: .popular) { tv in
            self.mainView.posterList[2] = tv
            group.leave()
        }
        
        
        
        group.notify(queue: .main) {
            self.mainView.topCollectionView.reloadData()
            self.mainView.mainTableView.reloadData()
        }
    }
    
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainView.posterList.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PosterTableViewCell", for: indexPath) as! PosterTableViewCell
        
        cell.titleLabel.text = mainView.listTitle[indexPath.row]
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: "Poster")
        cell.collectionView.tag = (indexPath.row) + 1
        cell.collectionView.reloadData()
        
        return cell
    }
    
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if mainView.topCollectionView == collectionView {
            return mainView.posterList[0].results.count
        } else {
            return mainView.posterList[collectionView.tag].results.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Poster", for: indexPath) as! PosterCollectionViewCell
        let imageBaseURL = "https://image.tmdb.org/t/p/w500"
        if mainView.topCollectionView == collectionView {
            let item = mainView.posterList[0].results[indexPath.row]
            
            if item.poster_path != nil {
                let url = URL(string: imageBaseURL + "\(item.poster_path ?? "")")
                cell.posterImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "suit.heart"))
            } else {
                cell.posterImageView.image = UIImage(systemName: "xmark")
            }
            cell.textLabel.text = mainView.newTitle.randomElement()
            cell.posterNameLabel.text = item.name
            
            return cell
        } else {
            let item = mainView.posterList[collectionView.tag].results[indexPath.row]
            
            if item.poster_path != nil {
                let url = URL(string: imageBaseURL + "\(item.poster_path ?? "")")
                cell.posterImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "suit.heart"))
            } else {
                cell.posterImageView.image = UIImage(systemName: "xmark")
            }
            cell.textLabel.text = mainView.newTitle.randomElement()
            cell.posterNameLabel.text = item.name
            
            return cell
        }
    }
    
    
}

#Preview {
    MainViewController()
}
