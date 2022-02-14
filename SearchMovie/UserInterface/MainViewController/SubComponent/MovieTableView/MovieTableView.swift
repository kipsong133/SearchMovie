//
//  MovieTableView.swift
//  SearchMovie
//
//  Created by 김우성 on 2022/02/10.
//

import UIKit
import RxSwift
import RxCocoa

class MovieTableView: UITableView {
    let disposeBag = DisposeBag()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupAttribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func bind(_ viewModel: MovieTableViewModel) {
        
        viewModel.cellData
            .drive(self.rx.items) { [weak self] tv, row, data in
                guard let self = self else { return UITableViewCell() }
                
                let index = IndexPath(row: row, section: 0)
                guard let cell = tv.dequeueReusableCell(
                    withIdentifier: MovieTableViewCell.identifier,
                    for: index) as? MovieTableViewCell else { return UITableViewCell() }
                cell.setupData(data)
                cell.favoriteButton.tag = row
                
                cell.favoriteButton.rx.tap
                    .map { cell.favoriteButton.tag }
                    .bind(to: viewModel.favoriteButtonTapped)
                    .disposed(by: self.disposeBag)
                
                return cell
            }
            .disposed(by: disposeBag)
        
        viewModel.searchButtonTapped
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {
                self.scrollToRow(
                    at: IndexPath(row: 0, section: 0),
                    at: .top,
                    animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func setupAttribute() {
        self.backgroundColor = .white
        self.register(
            MovieTableViewCell.self,
            forCellReuseIdentifier: MovieTableViewCell.identifier)
        self.separatorStyle = .singleLine
        self.rowHeight = 150
        self.tableFooterView = UIView()
    }
}
