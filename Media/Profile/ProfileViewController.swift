//
//  ProfileViewController.swift
//  Media
//
//  Created by 민지은 on 2024/02/08.
//

import UIKit
import Kingfisher

enum Profile: String, CaseIterable {
    case name = "이름"
    case nickName = "사용자 이름"
    case gender = "성별"
    case introduce = "소개"
    case link = "링크"
    
    static var allCases: [Profile] = [
                                        .name,
                                        .nickName,
                                        .gender,
                                        .introduce,
                                        .link
                                     ]
}

var profileInfo: [Profile : String] = [ .name : "",
                                        .nickName : "",
                                        .gender : "",
                                        .introduce : "",
                                        .link : ""
                                      ]

class ProfileViewController: UIViewController {

    let mainView = ProfileView()
    
    override func loadView() {
        self.view = mainView
        
        view.backgroundColor = .black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.profileTableView.delegate = self
        mainView.profileTableView.dataSource = self
        mainView.imageEditButton.addTarget(self, action: #selector(self.editButtonClicked), for: .touchUpInside)

    }
    
    @objc func editButtonClicked(sender: UIButton) {
        let vc = ImageSearchViewController()
        vc.selectImage = { value in
            let url = URL(string: value)
            self.mainView.profileImage.kf.setImage(with: url)
        }
        
        present(vc, animated: true)
    }

}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Profile.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Profile", for: indexPath) as! ProfileTableViewCell
        
        cell.titleLabel.text = Profile.allCases[indexPath.row].rawValue
        
        cell.profileLabel.text = profileInfo[Profile.allCases[indexPath.row]]!.isEmpty ? Profile.allCases[indexPath.row].rawValue : profileInfo[Profile.allCases[indexPath.row]]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ProfileEditViewController()
        vc.mainView.title = Profile.allCases[indexPath.row].rawValue
        vc.mainView.nowInput = profileInfo[Profile.allCases[indexPath.row]]!
        
        vc.inputInfo = { value in
            profileInfo[Profile.allCases[indexPath.row]] = value
            tableView.reloadData()
        }

        present(vc, animated: true)
    }
 
}

#Preview {
    ProfileViewController()
}
