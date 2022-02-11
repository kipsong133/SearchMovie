//
//  DetailViewController.swift
//  SearchMovie
//
//  Created by 김우성 on 2022/02/11.
//


import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    let webView = WKWebView()
    
    let url: URL
    
    init(url: URL?) {
        self.url = url!
        super.init(nibName: nil, bundle: nil)
        setupAttribute()
        setupLayout()
    }
    
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//
//
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAttribute() {
        view.backgroundColor = .white
    }
    
    private func setupLayout() {
        
        view.addSubview(webView)
        webView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        webView.load(URLRequest(url: url))
        
    }
    
    
}
