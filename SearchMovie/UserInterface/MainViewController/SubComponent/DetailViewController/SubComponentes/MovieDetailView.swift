//
//  MovieDetailView.swift
//  SearchMovie
//
//  Created by 김우성 on 2022/02/14.
//

import UIKit
import SnapKit
import Kingfisher

class MovieDetailView: UIView {
    
    let grayBorderlineView = UIView()
    let movieImageView = UIImageView()
    let stackView = UIStackView()
    let directorLabel = UILabel()
    let performerLabel = UILabel()
    let ratingLabel = UILabel()
    let favoriteButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAttribute()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupData(_ cellData: MovieCellData) {
        print(cellData)
        movieImageView.kf.setImage(with: cellData.thumbnailURL, placeholder: UIImage(systemName: "photo"))
        directorLabel.text = "감독: \(cellData.filmDirector ?? "-")"
        performerLabel.text = "출연: \(cellData.performer ?? "-")"
        ratingLabel.text = "평점: \(cellData.rating ?? "-")"
    }
    
    private func setupAttribute() {
        grayBorderlineView.backgroundColor = .lightGray.withAlphaComponent(0.33)
        
        movieImageView.contentMode = .scaleAspectFit
        movieImageView.layer.borderColor = UIColor.lightGray.cgColor
        movieImageView.layer.borderWidth = 0.5
        
        directorLabel.text = "감독:"
        performerLabel.text = "출연:"
        ratingLabel.text = "평점:"
        
        [directorLabel, performerLabel, ratingLabel]
            .forEach {
                $0.textColor = .black
                $0.font = .systemFont(ofSize: 13)
            }
        
        favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        favoriteButton.imageView?.tintColor = .yellow
        
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        stackView.axis = .vertical
        stackView.contentMode = .left
        stackView.backgroundColor = .white
    }
    
    private func setupLayout() {
        self.addSubview(grayBorderlineView)
        
        [movieImageView,  favoriteButton]
            .forEach { self.addSubview($0)}
        
        [directorLabel, performerLabel, ratingLabel]
            .forEach { stackView.addArrangedSubview($0) }
        
        grayBorderlineView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(10)
        }
        
        movieImageView.snp.makeConstraints {
            $0.top.equalTo(grayBorderlineView.snp.bottom).offset(5)
            $0.bottom.equalToSuperview().inset(5)
            $0.leading.equalToSuperview().offset(15)
            $0.width.equalToSuperview().multipliedBy(0.17)
        }
        
        favoriteButton.snp.makeConstraints {
            $0.top.equalTo(movieImageView)
            $0.trailing.equalToSuperview().inset(15)
            $0.height.width.equalTo(25)
        }
        
        self.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.bottom.equalTo(movieImageView)
            $0.leading.equalTo(movieImageView.snp.trailing).offset(7)
            $0.trailing.equalTo(favoriteButton.snp.leading).inset(5)
        }
    }
}
