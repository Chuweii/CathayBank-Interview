//
//  File.swift
//  CathayBankInterview
//
//  Created by Wei Chu on 2024/8/21.
//

import UIKit

class MyFavoriteView: UIView {
    enum Option: String {
        case transfer = "Transfer"
        case payment = "Payment"
        case utility = "Utility"
        case qrPayScan = "QR pay scan"
        case myQRCode = "My QR code"
        case topup = "Topup"
    }
    
    private var views: [UIView] = []
    private var favoriteArray: [FavoriteModel] = []
    // constraint Spacing
    private let stackSize: CGFloat = 96
    private let imageSize: CGFloat = 56
    private let btnImageSize: CGFloat = 24
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setUpCollcetionView()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI
    private let aStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 40
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let bStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 40
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "My Favorite"
        label.textColor = .lightGray
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let moreLabel: UILabel = {
        let label = UILabel()
        label.text = "More"
        label.textColor = .gray300
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rightArrowImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "iconArrow01Next")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let defaultsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let defaultsImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "Defaults")
        imageView.layer.cornerRadius = 20
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let defaultsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "- - -"
        label.textColor = .gray300
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let defaultsExplanationsLabel: UILabel = {
        let label = UILabel()
        label.text = "You can add a favorite through the transfer or payment function."
        label.textColor = .gray300
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    //MARK: - setup
    private func setupViews() {
        let viewsToAdd: [UIView] = [
            aStackView,
            bStackView,
            titleLabel,
            moreLabel,
            rightArrowImageView,
            collectionView,
            defaultsView,
        ]
        viewsToAdd.forEach { self.addSubview($0) }
        
        // defaultsView
        let viewsToAddDefaultsView: [UIView] = [
            defaultsImageView,
            defaultsTitleLabel,
            defaultsExplanationsLabel,
        ]
        viewsToAddDefaultsView.forEach { defaultsView.addSubview($0) }
    }
    
    private func setupConstraint() {
        let topAnchor = self.topAnchor
        let leftAnchor = self.leftAnchor
        let rightAnchor = self.rightAnchor
        let bottomAnchor = self.bottomAnchor
        
        NSLayoutConstraint.activate([
            aStackView.topAnchor.constraint(equalTo: topAnchor),
            aStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 34),
            aStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -34),
            aStackView.heightAnchor.constraint(equalToConstant: stackSize),
            
            bStackView.topAnchor.constraint(equalTo: aStackView.bottomAnchor, constant: 8),
            bStackView.leftAnchor.constraint(equalTo: aStackView.leftAnchor),
            bStackView.rightAnchor.constraint(equalTo: aStackView.rightAnchor),
            bStackView.heightAnchor.constraint(equalToConstant: stackSize),
            
            titleLabel.topAnchor.constraint(equalTo: bStackView.bottomAnchor, constant: 16),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            titleLabel.rightAnchor.constraint(equalTo: moreLabel.leftAnchor),
            
            moreLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            moreLabel.rightAnchor.constraint(equalTo: rightArrowImageView.leftAnchor),
            
            rightArrowImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
            rightArrowImageView.centerYAnchor.constraint(equalTo: moreLabel.centerYAnchor),
            rightArrowImageView.heightAnchor.constraint(equalToConstant: btnImageSize),
            rightArrowImageView.widthAnchor.constraint(equalToConstant: btnImageSize),
            
            // use data show CollectionView
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            collectionView.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightArrowImageView.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            collectionView.heightAnchor.constraint(equalToConstant: 88),
            
            // no use dat show DefaultsView
            defaultsView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            defaultsView.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            defaultsView.rightAnchor.constraint(equalTo: rightArrowImageView.rightAnchor),
            defaultsView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            defaultsImageView.topAnchor.constraint(equalTo: defaultsView.topAnchor, constant: 2),
            defaultsImageView.leftAnchor.constraint(equalTo: defaultsView.leftAnchor, constant: 2),
            defaultsImageView.heightAnchor.constraint(equalToConstant: imageSize),
            defaultsImageView.widthAnchor.constraint(equalToConstant: imageSize),
            
            defaultsTitleLabel.topAnchor.constraint(equalTo: defaultsImageView.bottomAnchor, constant: 2),
            defaultsTitleLabel.leftAnchor.constraint(equalTo: defaultsView.leftAnchor, constant: 2),
            defaultsTitleLabel.bottomAnchor.constraint(equalTo: defaultsView.bottomAnchor),
            defaultsTitleLabel.centerXAnchor.constraint(equalTo: defaultsImageView.centerXAnchor),
            
            defaultsExplanationsLabel.centerYAnchor.constraint(equalTo: defaultsImageView.centerYAnchor),
            defaultsExplanationsLabel.leftAnchor.constraint(equalTo: defaultsImageView.rightAnchor, constant: 12),
            defaultsExplanationsLabel.rightAnchor.constraint(equalTo: defaultsView.rightAnchor, constant: -2),
        ])
    }
    
    private func setUpCollcetionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(FavoriteCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: FavoriteCollectionViewCell.self))
    }
    
    private func updateStackView(option: Option, stackView: UIStackView) {
        let view = createButtonView(title: option.rawValue, image: option.rawValue)
        stackView.addArrangedSubview(view)
    }
    
    private func createButtonView(title: String, image: String) -> UIView {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false

        let imageView = UIImageView()
        imageView.image = UIImage(named: image)
        imageView.layer.cornerRadius = 20
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .gray300
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(titleLabel)
        containerView.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 2),
            imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: imageSize),
            imageView.widthAnchor.constraint(equalToConstant: imageSize),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 2),
            titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 2),
            titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 2),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])

        return containerView
    }
    
    func configure(isFirstLogin: Bool, favoriteArray: [FavoriteModel]) {
        if isFirstLogin {
            // add button View
            updateStackView(option: .transfer, stackView: aStackView)
            updateStackView(option: .payment, stackView: aStackView)
            updateStackView(option: .utility, stackView: aStackView)
            
            updateStackView(option: .qrPayScan, stackView: bStackView)
            updateStackView(option: .myQRCode, stackView: bStackView)
            updateStackView(option: .topup, stackView: bStackView)
            
            collectionView.isHidden = isFirstLogin
            defaultsView.isHidden = !isFirstLogin
        } else {
            self.favoriteArray = favoriteArray
            collectionView.isHidden = false
            defaultsView.isHidden = true
        }
        collectionView.reloadData()
    }
}

//MARK:  - Collection
extension MyFavoriteView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FavoriteCollectionViewCell.self), for: indexPath) as! FavoriteCollectionViewCell
        
        cell.configure(title: favoriteArray[indexPath.row].transType)
        
        return cell
    }
    
    // UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width/5,
                      height: collectionView.bounds.height)
    }
}

