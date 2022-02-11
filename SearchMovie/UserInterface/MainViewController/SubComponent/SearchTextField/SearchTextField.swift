//
//  SearchBar.swift
//  SearchMovie
//
//  Created by 김우성 on 2022/02/10.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SearchTextField: UITextField {
    let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAttribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func bind(_ viewModel: SearchTextFieldViewModel) {
        self.rx.text
            .bind(to: viewModel.queryText)
            .disposed(by: disposeBag)
        
        self.rx.controlEvent([.editingDidEndOnExit])
            .asObservable()
            .bind(to: viewModel.returnButtonTapped)
            .disposed(by: disposeBag)
    }
    
    private func setupAttribute() {
        self.borderStyle = .roundedRect
    }
}
