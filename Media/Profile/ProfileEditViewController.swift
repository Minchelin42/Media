//
//  ProfileEditViewController.swift
//  Media
//
//  Created by 민지은 on 2024/02/08.
//

import UIKit

class ProfileEditViewController: UIViewController {

    var inputInfo: ((String) -> Void)?
    let mainView = ProfileEditView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        
        mainView.inputTextField.delegate = self
        
        mainView.titleLabel.text = "\(mainView.title)"
        mainView.inputTextField.text = "\(mainView.nowInput)"
        mainView.inputTextField.placeholder = "\(mainView.title)"
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

extension ProfileEditViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputInfo?(mainView.inputTextField.text!)
        dismiss(animated: true)
        return true
    }
}

#Preview {
    ProfileEditViewController()
}
