//
//  EpisodeDetailViewController.swift
//  Media
//
//  Created by 민지은 on 2024/02/04.
//

import UIKit
import Kingfisher

class EpisodeDetailViewController: UIViewController {

    let mainView = EpisodeDetailView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        TVAPIManager.shared.APIcall(type: EpisodeDetailModel.self, api: .episodeDetail(code: mainView.id, season: mainView.season)) { result, error in
            if let result = result {
                self.mainView.episode = result
                self.mainView.tableView.reloadData()
                self.mainView.configureView()
            } else {
                print("지금 통신에 뭔가 문제가 있다 내 문제는 잠이 너무 오는 것임ㅠ...")
            }
        }
        
    }

}

extension EpisodeDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainView.episode.episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeDetailTableViewCell", for: indexPath) as! EpisodeDetailTableViewCell
        let item = mainView.episode.episodes[indexPath.row]
        cell.episodeTitle.text = "\(indexPath.row + 1). \(item.name)"
        cell.overView.text = item.overview
        
        let baseImageURL = "https://image.tmdb.org/t/p/w500"
        if let url = item.still_path {
            cell.stillImage.kf.setImage(with: URL(string: baseImageURL + "\(url)"))
        } else {
            cell.stillImage.image = UIImage(systemName: "xmark")
        }
        
        cell.timeLabel.text = "\(item.runtime)분"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    
}

#Preview {
    EpisodeDetailViewController()
}
