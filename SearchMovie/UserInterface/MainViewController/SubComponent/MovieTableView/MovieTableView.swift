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
            .drive(self.rx.items) { tv, row, data in
                let index = IndexPath(row: row, section: 0)
                guard let cell = tv.dequeueReusableCell(
                    withIdentifier: MovieTableViewCell.identifier,
                    for: index) as? MovieTableViewCell else { return UITableViewCell() }
                cell.setupData(data)
                return cell
            }
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
