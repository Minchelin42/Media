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

    lazy var topCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    let mainTableView = UITableView()
    
    var posterList: [TVModel] = [
        TVModel(results: []),
        TVModel(results: []),
        TVModel(results: [])
    ]
    
    let APIList = ["trending/tv/day", "tv/top_rated", "tv/popular"]
    
    let listTitle = ["Top Rated List", "Popular List"]
    
    let newTitle = ["새로운 에피소드", "새로운 시리즈", "새로운 작품"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(posterList)
        
        view.backgroundColor = .black
        
        configureHierarchy()
        configureLayout()
        configureView()
        
        for index in 0...APIList.count - 1 {
            TVAPIManager.shared.getTVAPI(APItype: APIList[index]) { tv in
                self.posterList[index] = tv
                self.topCollectionView.reloadData()
                self.mainTableView.reloadData()
            }
        }
    }
    
    func configureHierarchy(){
        view.addSubview(topCollectionView)
        view.addSubview(mainTableView)
    }
    
    func configureLayout(){
        topCollectionView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(250)
        }
        
        mainTableView.snp.makeConstraints { make in
            make.top.equalTo(topCollectionView.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureView(){
        topCollectionView.backgroundColor = .clear
        topCollectionView.delegate = self
        topCollectionView.dataSource = self
        topCollectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: "Poster")
        
        mainTableView.backgroundColor = .clear
        mainTableView.delegate = self
        mainTableView.dataSource = self
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

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return APIList.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PosterTableViewCell", for: indexPath) as! PosterTableViewCell
        
        cell.titleLabel.text = listTitle[indexPath.row]
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
        if topCollectionView == collectionView {
            return posterList[0].results.count
        } else {
            return posterList[collectionView.tag].results.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Poster", for: indexPath) as! PosterCollectionViewCell
        
        if topCollectionView == collectionView {
            let item = posterList[0].results[indexPath.row]
            
            if item.poster_path != nil {
                let url = URL(string:"https://image.tmdb.org/t/p/w500\(item.poster_path ?? "")")
                cell.posterImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "suit.heart"))
            } else {
                cell.posterImageView.image = UIImage(systemName: "xmark")
            }
            cell.textLabel.text = newTitle.randomElement()
            cell.posterNameLabel.text = item.name
            
            return cell
        } else {
            let item = posterList[collectionView.tag].results[indexPath.row]
            
            if item.poster_path != nil {
                let url = URL(string:"https://image.tmdb.org/t/p/w500\(item.poster_path ?? "")")
                cell.posterImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "suit.heart"))
            } else {
                cell.posterImageView.image = UIImage(systemName: "xmark")
            }
            cell.textLabel.text = newTitle.randomElement()
            cell.posterNameLabel.text = item.name
            
            return cell
        }
    }
    
    
}



#Preview {
    MainViewController()
}
