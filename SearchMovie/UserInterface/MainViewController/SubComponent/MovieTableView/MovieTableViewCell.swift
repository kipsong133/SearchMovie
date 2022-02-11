//
//  MovieTableViewCell.swift
//  SearchMovie
//
//  Created by 김우성 on 2022/02/10.
//

import UIKit
import Kingfisher
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
        setupAttribute()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupData(_ data: MovieCellData) {
        if let imageURL = data.thumbnailURL {
            thumbnailImageView.kf.setImage(with: imageURL, placeholder: UIImage(systemName: "photo"))
        }
        titleLabel.text = data.name ?? ""
        directorLabel.text = "감독: " + (data.filmDirector ?? "")
        performerLabel.text = "출연: " + (data.performer ?? "")
        ratingLabel.text = "평점: " + (data.rating ?? "")
    }
    
    private func setupAttribute() {
        self.selectionStyle = .none

        favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        favoriteButton.imageView?.tintColor = .lightGray
        
        titleLabel.font = .systemFont(ofSize: 15, weight: .bold)
        
        [directorLabel, performerLabel, ratingLabel]
            .forEach { $0.font = .systemFont(ofSize: 13) }
        
        // default value
        thumbnailImageView.contentMode = .scaleAspectFit
        thumbnailImageView.image = UIImage(systemName: "photo")
        thumbnailImageView.tintColor = .lightGray.withAlphaComponent(0.5)
        thumbnailImageView.backgroundColor = .white
        thumbnailImageView.layer.borderColor = UIColor.lightGray.cgColor
        thumbnailImageView.layer.borderWidth = 0.5
        thumbnailImageView.layer.masksToBounds = true
        thumbnailImageView.layer.cornerRadius = 4
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
        
        favoriteButton.snp.makeConstraints {
            $0.top.equalTo(thumbnailImageView)
            $0.trailing.equalToSuperview().inset(15)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(thumbnailImageView)
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(5)
            $0.trailing.lessThanOrEqualTo(favoriteButton.snp.leading)
        }
        
        directorLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(3)
            $0.leading.equalTo(titleLabel)
            $0.trailing.lessThanOrEqualTo(favoriteButton.snp.leading)
        }
        
        performerLabel.snp.makeConstraints {
            $0.top.equalTo(directorLabel.snp.bottom).offset(3)
            $0.leading.equalTo(titleLabel)
            $0.trailing.lessThanOrEqualTo(favoriteButton.snp.leading)
        }
        
        ratingLabel.snp.makeConstraints {
            $0.top.equalTo(performerLabel.snp.bottom).offset(3)
            $0.leading.equalTo(performerLabel)
            $0.trailing.lessThanOrEqualTo(favoriteButton.snp.leading)
        }
    }
}
