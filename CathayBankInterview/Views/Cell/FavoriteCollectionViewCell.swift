//
//  File.swift
//  CathayBankInterview
//
//  Created by Wei Chu on 2024/8/21.
//

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraint()
    }
    
    private let favoriteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let favoriteTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupViews() {
        contentView.addSubview(favoriteImageView)
        contentView.addSubview(favoriteTitleLabel)
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
            favoriteImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            favoriteImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            favoriteImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            favoriteImageView.centerXAnchor.constraint(equalTo: favoriteTitleLabel.centerXAnchor),
            
            favoriteTitleLabel.topAnchor.constraint(equalTo: favoriteImageView.bottomAnchor),
            favoriteTitleLabel.leadingAnchor.constraint(equalTo: favoriteImageView.leadingAnchor),
            favoriteTitleLabel.trailingAnchor.constraint(equalTo: favoriteImageView.trailingAnchor),
            favoriteTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2)
        ])
    }
    
    func configure(title: String) {
        let testImage = ["CredirCard", "CUBC", "Mobile", "PMF"]
        let randomIndex = Int(arc4random_uniform(UInt32(testImage.count)))
        let imageName = testImage[randomIndex]
        
        favoriteImageView.image = UIImage(named: imageName)
        favoriteTitleLabel.text = title
    }
}
