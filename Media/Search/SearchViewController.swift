//
//  SearchViewController.swift
//  Media
//
//  Created by 민지은 on 2024/02/03.
//

import UIKit
import Kingfisher

class SearchViewController: UIViewController {

    let mainView = SearchView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        mainView.searchBar.delegate = self
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self

    }

}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainView.resultList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Poster", for: indexPath) as! PosterCollectionViewCell
        
        let imageBaseURL = "https://image.tmdb.org/t/p/w500"
        let item = mainView.resultList[indexPath.row]
        
        if let url = item.poster_path {
            cell.posterImageView.kf.setImage(with: URL(string: imageBaseURL + "\(url)"), placeholder: UIImage(systemName: "suit.heart"))
        } else {
            cell.posterImageView.image = UIImage(systemName: "xmark")
        }
        
        cell.posterNameLabel.isHidden = true
        cell.textLabel.isHidden = true

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let vc = EpisodeViewController()
        
        vc.mainView.dramaCode = mainView.resultList[indexPath.row].id
        present(vc, animated: true)
        
    }

}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        TVAPIManager.shared.APIcall(type: TVModel.self, api: .search(query: searchBar.text!)) { result, error in
            if let result = result {
                self.mainView.resultList = result.results
                self.mainView.collectionView.reloadData()
                self.view.endEditing(true)
            } else {
                print("지금 통신에 뭔가 문제가 있다 내 문제는 잠이 너무 오는 것임ㅠ...")
            }
        }
    }
}

#Preview {
    
    SearchViewController()
    
}
