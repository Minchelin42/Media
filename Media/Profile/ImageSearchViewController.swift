//
//  ImageSearchViewController.swift
//  Media
//
//  Created by 민지은 on 2024/02/13.
//

import UIKit
import Kingfisher

class ImageSearchViewController: UIViewController {
    
    var selectImage: ((String) -> Void)?
    let mainView = ImageSearchView()
    var start = 1
    
    var resultImage = NaverModel(total: 0, display: 0, items: [])
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        
        mainView.searchBar.delegate = self
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.prefetchDataSource = self
        
    }

}

extension ImageSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.resultImage.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Casting", for: indexPath) as! CastingCollectionViewCell
        cell.nameLabel.text = ""
        
        let url = URL(string: self.resultImage.items[indexPath.row].link)
        cell.personImage.kf.setImage(with: url, placeholder: UIImage(systemName: "photo"))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(resultImage.items[indexPath.row].link)
        selectImage?(resultImage.items[indexPath.row].link)
        dismiss(animated: true)
    }
    
}

extension ImageSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //검색 API 호출
        print("searchBar 검색")
        start = 1
        NaverAPIManager.shared.ImageAPI(search: searchBar.text!, start: start) {
            image, error in
            if let image = image {
                self.resultImage = image
            } else {
                print("통신 실패")
            }
            self.mainView.collectionView.reloadData()
            self.mainView.searchResultLabel.text = "  \(self.resultImage.total.prettyNumber)개의 검색 결과"
        }
        
    }
}

extension ImageSearchViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print("Prefetch \(indexPaths)")

        print("total: \(self.resultImage.total)\n display: \(self.resultImage.display)")
        if !self.resultImage.items.isEmpty {
            for indexPath in indexPaths {
                if self.resultImage.items.count - 5 == indexPath.row && start + self.resultImage.display < self.resultImage.total {
                    self.start += 30
                    NaverAPIManager.shared.ImageAPI(search: self.mainView.searchBar.text!, start: self.start) {
                        image, error in
                        print("searchBar: \(self.mainView.searchBar.text!)\nstart:\(self.start)\nlistCount: \(self.resultImage.items.count)")
                        if let image = image {
                            if self.resultImage.items.count == 0 {
                                self.resultImage = image
                            } else {
                                self.resultImage.items.append(contentsOf: image.items)
                                print(self.resultImage.items.count)
                            }
                            
                            self.mainView.collectionView.reloadData()
                            
                            if self.start == 1 && !self.resultImage.items.isEmpty{
                                self.mainView.collectionView.scrollToItem(at: [0, 0], at: .bottom, animated: false)
                            }
                        } else {
                            print("통신 실패")
                        }
                    }
                    
                }
            }
        }
    }
}

extension Int {
    var prettyNumber: String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        formatter.locale = .init(identifier: "ko")
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
