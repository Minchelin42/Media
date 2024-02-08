//
//  ProfileViewController.swift
//  Media
//
//  Created by 민지은 on 2024/02/08.
//

import UIKit

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

var profileInfo = ["", "", "", "", ""]

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

    }

}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Profile.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Profile", for: indexPath) as! ProfileTableViewCell
        
        cell.titleLabel.text = Profile.allCases[indexPath.row].rawValue
        
        cell.profileLabel.text = profileInfo[indexPath.row].isEmpty ? Profile.allCases[indexPath.row].rawValue : profileInfo[indexPath.row]
        
        return cell
    }
 
}

#Preview {
    ProfileViewController()
}