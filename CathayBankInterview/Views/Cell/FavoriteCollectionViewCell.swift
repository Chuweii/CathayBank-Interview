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
        favoriteImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            make.centerX.equalTo(favoriteTitleLabel.snp.centerX)
        }
        
        favoriteTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(favoriteImageView.snp.bottom)
            make.leading.equalTo(favoriteImageView.snp.leading)
            make.trailing.equalTo(favoriteImageView.snp.trailing)
            make.bottom.equalTo(contentView.snp.bottom).offset(-2)
        }
    }
    
    func configure(title: String) {
        let testImage = ["CredirCard", "CUBC", "Mobile", "PMF"]
        let randomIndex = Int(arc4random_uniform(UInt32(testImage.count)))
        let imageName = testImage[randomIndex]
        
        favoriteImageView.image = UIImage(named: imageName)
        favoriteTitleLabel.text = title
    }
}
