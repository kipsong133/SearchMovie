//
//  DetailViewController.swift
//  SearchMovie
//
//  Created by 김우성 on 2022/02/11.
//


import UIKit
import SnapKit
import WebKit


class DetailViewController: UIViewController {
    
    let movieDetailView = MovieDetailView()
    let webView = WKWebView()
    
    let cellData: MovieCellData
    init(cellData: MovieCellData?) {
        self.cellData = cellData!
        super.init(nibName: nil, bundle: nil)
        setupAttribute()
        setupLayout()
        if let cellData = cellData {
            setupData(cellData)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupData(_ cellData: MovieCellData) {
        movieDetailView.setupData(cellData)
    }
    
    private func setupAttribute() {
        view.backgroundColor = .white
        self.title = cellData.name ?? "영화이름"
    }
    
    private func setupLayout() {
        
        [movieDetailView, webView].forEach { view.addSubview($0) }
        
        movieDetailView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.15)
        }
        
        webView.snp.makeConstraints {
            $0.top.equalTo(movieDetailView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        let url = URL(string: cellData.link ?? "")!
        webView.load(URLRequest(url: url))
    }
    
    
}
