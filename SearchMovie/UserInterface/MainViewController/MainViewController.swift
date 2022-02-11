//
//  MainViewController.swift
//  SearchMovie
//
//  Created by 김우성 on 2022/02/10.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let movieTableView = MovieTableView()
    let rightButton = UIButton()
    
    let searchTextField = SearchTextField()
 
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupAttribute()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func bind(_ viewModel: MainViewModel) {
        searchTextField
            .bind(viewModel.searchTextFieldViewModel)
        
        movieTableView
            .bind(viewModel.movieTableViewModel)
        
        viewModel.push
            .drive(onNext: { url in
                let detailViewController = DetailViewController(url: url!)
                self.show(detailViewController, sender: nil)
            })
            .disposed(by: disposeBag)
        
        movieTableView.rx.itemSelected
            .map { $0.row }
            .bind(to: viewModel.itemSelected)
            .disposed(by: disposeBag)
        
        
    }
    
    private func setupAttribute() {
        view.backgroundColor = .white
        
        /* title(Right) */
        let navigationTitleLabel = UILabel()
        navigationTitleLabel.font = .systemFont(ofSize: 23, weight: .black)
        navigationTitleLabel.textColor = UIColor.black
        navigationTitleLabel.text = "네이버 영화검색"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: navigationTitleLabel)
        
        /* Favorite Button(Left) */
        rightButton.frame = CGRect(origin: .zero, size: CGSize(width: 85, height: 30))
        rightButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        rightButton.imageView?.tintColor = .yellow
        rightButton.setTitle("즐겨찾기", for: .normal)
        rightButton.titleLabel?.font = .systemFont(ofSize: 15)
        rightButton.setTitleColor(.black, for: .normal)
        rightButton.layer.borderWidth = 1
        rightButton.layer.borderColor = UIColor.lightGray.cgColor
        let favoriteButton = UIBarButtonItem(customView: rightButton)
        navigationItem.setRightBarButton(favoriteButton, animated: true)
        
        
    }
    
    private func setupLayout() {
        [
            searchTextField,
            movieTableView
        ]
        .forEach { view.addSubview($0) }
        
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            $0.leading.trailing.equalToSuperview().inset(15)
        }
        
        movieTableView.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(5)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

