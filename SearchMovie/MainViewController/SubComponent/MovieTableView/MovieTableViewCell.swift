//
//  MovieTableViewCell.swift
//  SearchMovie
//
//  Created by 김우성 on 2022/02/10.
//

import UIKit
import SnapKit

class MovieTableViewCell: UITableViewCell {
    static let identifier = "MovieTableViewCell"
    
    private let thumbnailImageView = UIImageView()
    public let favoriteButton = UIButton()
    private let titleLabel = UILabel()
    private let directorLabel = UILabel()
    private let performerLabel = UILabel()
    private let ratingLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupAttribute()
        setupLayout()
    }
    
    public func setupData(_ data: MovieCellData) {
        
    }
    
    private func setupAttribute() {
        self.selectionStyle = .none
        
        thumbnailImageView.contentMode = .scaleAspectFit
        
        favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        favoriteButton.imageView?.tintColor = .lightGray
        
        titleLabel.font = .systemFont(ofSize: 15, weight: .bold)
        
        [directorLabel, performerLabel, ratingLabel]
            .forEach { $0.font = .systemFont(ofSize: 13) }
        
        // default value
        thumbnailImageView.image = UIImage(systemName: "photo")
        thumbnailImageView.backgroundColor = .lightGray
        titleLabel.text = "제목"
        directorLabel.text = "감독: "
        performerLabel.text = "출연: "
        ratingLabel.text = "평점: "
        
    }
    
    private func setupLayout() {
        [
            thumbnailImageView, favoriteButton,
            titleLabel,
            directorLabel,
            performerLabel,
            ratingLabel
        ].forEach { contentView.addSubview($0) }
        
        thumbnailImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.top.equalToSuperview().offset(7.5)
            $0.bottom.equalToSuperview().inset(7.5)
            $0.width.equalToSuperview().multipliedBy(0.25)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(thumbnailImageView)
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(5)
        }
        
        directorLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(3)
            $0.leading.equalTo(titleLabel)
        }
        
        performerLabel.snp.makeConstraints {
            $0.top.equalTo(directorLabel.snp.bottom).offset(3)
            $0.leading.equalTo(titleLabel)
        }
        
        ratingLabel.snp.makeConstraints {
            $0.top.equalTo(performerLabel.snp.bottom).offset(3)
            $0.leading.equalTo(performerLabel)
        }
    }
}
