//
//  VideoView.swift
//  Media
//
//  Created by 민지은 on 2024/02/12.
//

import UIKit
import WebKit

class VideoView: BaseView {
    
    let webView = WKWebView()
    var key = ""
    
    override func configureHierarchy() {
        addSubview(webView)
    }
    
    override func configureLayout() {
        webView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        if let url = URL(string: "https://www.youtube.com/watch?v=\(key)") {

            let request = URLRequest(url: url)
            
            webView.load(request)
        } else {
            webView.isOpaque = false
            webView.backgroundColor = .clear
        }
    }

}
