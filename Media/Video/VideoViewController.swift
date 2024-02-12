//
//  VideoViewController.swift
//  Media
//
//  Created by 민지은 on 2024/02/12.
//

import UIKit
import WebKit

class VideoViewController: UIViewController {

    let mainView = VideoView()
    
    override func loadView() {
        self.view = mainView
        mainView.configureView()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
    }
 
}

#Preview {
    VideoViewController()
}
