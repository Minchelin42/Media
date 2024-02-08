//
//  ProfileEditViewController.swift
//  Media
//
//  Created by 민지은 on 2024/02/08.
//

import UIKit

class ProfileEditViewController: UIViewController {

    var nowEdit: Profile = Profile.name
    
    let mainView = ProfileEditView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
    }
}

extension UITextField {
    
    func clearButtonWithImage(_ image: UIImage) {
        let clearButton = UIButton()
        clearButton.setImage(image, for: .normal)
        clearButton.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        clearButton.tintColor = .gray
        clearButton.contentMode = .scaleAspectFit
        clearButton.addTarget(self, action: #selector(self.textFieldclear), for: .touchUpInside)
        self.rightView = clearButton
        self.rightViewMode = .whileEditing
    }
    
    @objc func textFieldclear(sender: UIButton) {
        self.text = ""
    }
}

#Preview {
    ProfileEditViewController()
}
