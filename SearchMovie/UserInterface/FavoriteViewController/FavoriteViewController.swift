//
//  FavoriteViewController.swift
//  SearchMovie
//
//  Created by 김우성 on 2022/02/14.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class FavoriteViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let favoriteTableView = FavoriteTableView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupAttribute()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func bind(_ viewModel: FavoriteViewModel) {
        favoriteTableView.bind(viewModel.favoriteTableViewModel)
        
        viewModel.title
            .drive(self.rx.title)
            .disposed(by: disposeBag)
        
        favoriteTableView.rx.itemSelected
            .map { $0.row }
            .bind(to: viewModel.itemSelected)
            .disposed(by: disposeBag)
        
        viewModel.pushDetail
            .drive(onNext: { cellData in
                let detailViewController = DetailViewController(cellData: cellData)
                self.navigationController?.pushViewController(detailViewController, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func setupAttribute() {
        view.backgroundColor = .white
    }
    
    private func setupLayout() {
        view.addSubview(favoriteTableView)
        
        favoriteTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

