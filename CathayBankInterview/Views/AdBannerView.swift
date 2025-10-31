//
//  File.swift
//  CathayBankInterview
//
//  Created by Wei Chu on 2025/10/28.
//

import Foundation
import UIKit

class AdBannerView: UIView {
    private var adBanners: [BannerModel] = []
    private var timer: Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraint()
        setUpCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        stopAutoScroll()
    }
    
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        if newWindow == nil {
            stopAutoScroll()
        } else {
            updateAutoScrollIfNeeded()
        }
    }
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 0
        pageControl.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    private func setupViews() {
        let viewsToAdd: [UIView] = [
            collectionView,
            pageControl,
        ]
        viewsToAdd.forEach { self.addSubview($0) }
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            collectionView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 4),
            pageControl.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            pageControl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
            pageControl.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(AdBannerCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: AdBannerCollectionViewCell.self))
    }
    
    func configure(isFirstLogin: Bool, adBanners: [BannerModel]) {
        self.adBanners = adBanners
        pageControl.numberOfPages = adBanners.count
        pageControl.currentPage = 0
        collectionView.setContentOffset(.zero, animated: false)
        collectionView.reloadData()
        updateAutoScrollIfNeeded()
    }
    
    private func updateAutoScrollIfNeeded() {
        if adBanners.count > 1, window != nil {
            startAutoScroll()
        } else {
            stopAutoScroll()
        }
    }
    
    func startAutoScroll() {
        stopAutoScroll()
        guard adBanners.count > 1 else { return }
        timer = Timer.scheduledTimer(timeInterval: 3,
                                     target: self,
                                     selector: #selector(scrollToNextPage),
                                     userInfo: nil,
                                     repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    func stopAutoScroll() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func scrollToNextPage() {
        guard adBanners.count > 1 else { return }
        guard collectionView.bounds.width > 0 else { return }
        
        let currentPage = pageControl.currentPage
        let nextPage = (currentPage + 1) % adBanners.count
        
        let nextIndexPath = IndexPath(item: nextPage, section: 0)
        if nextPage < adBanners.count {
            collectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = nextPage
        }
    }
}

//MARK: - CollectionViewDelegate

extension AdBannerView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return adBanners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: AdBannerCollectionViewCell.self), for: indexPath) as? AdBannerCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(image: adBanners[indexPath.row].linkUrl)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width,
                      height: collectionView.bounds.height)
    }
}

//MARK: - UIScrollViewDelegate

extension AdBannerView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard scrollView.bounds.width > 0 else { return }
        let page = (scrollView.contentOffset.x / scrollView.frame.size.width).rounded()
        pageControl.currentPage = Int(page)
    }
}

//MARK: - AdBannerCollectionViewCell

class AdBannerCollectionViewCell: UICollectionViewCell {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraint()
    }
    
    private let adImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private func setupViews() {
        contentView.addSubview(adImageView)
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
            adImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            adImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            adImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            adImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(image: String) {
        adImageView.downloadImage(urlString: image) { result in
            switch result {
            case .success(let image):
                if let image = image {
                    self.adImageView.image = image
                } else {
                    let defaultImage = UIImage(named: "welcome_ad_default") ?? UIImage()
                    self.adImageView.image = defaultImage
                }
            case .failure(_):
                let defaultImage = UIImage(named: "welcome_ad_default") ?? UIImage()
                self.adImageView.image = defaultImage
            }
        }
    }
}
