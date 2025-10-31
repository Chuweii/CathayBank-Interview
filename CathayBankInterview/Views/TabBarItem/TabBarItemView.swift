//
//  TabBarItemView.swift
//  CathayBankInterview
//
//  Created by Wei Chu on 2025/10/28.
//

import Foundation
import UIKit

protocol TabBarItemViewDelegate: AnyObject {
    func tapHandler(_ view: TabBarItemView)
}

class TabBarItemView: UIView {
    
    // MARK: - Properties
    
    private let image: String
    private let title: String
    weak var delegate: TabBarItemViewDelegate?
    private let selectedColor: UIColor = .orange
    private let normalColor: UIColor = .gray
    public var isSelected: Bool = false {
        willSet {
            updateUI(isSelected: newValue)
        }
    }
    
    // MARK: - Init
    
    init(image: String, title: String) {
        self.image = image
        self.title = title
        super.init(frame: .zero)
        setupView()
        addTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraint()
    }
    
    // MARK: - Methods
    
    private func updateUI(isSelected: Bool) {
        iconImageView.tintColor = isSelected ? selectedColor : normalColor
        titleLabel.textColor = isSelected ? selectedColor : normalColor
    }
    
    // MARK: - UIElements
    
    private let containerView = UIView()
    
    private lazy var iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: image)
        iv.tintColor = normalColor
        return iv
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.sizeToFit()
        label.text = title
        label.textColor = normalColor
        return label
    }()
    
    // MARK: - Setup View

    private func setupView() {
        backgroundColor = .clear
        containerView.addSubview(iconImageView)
        containerView.addSubview(titleLabel)
        addSubview(containerView)
        
        // Set translatesAutoresizingMaskIntoConstraints to false for all views
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
            // Icon image view constraints
            iconImageView.widthAnchor.constraint(equalToConstant: 25),
            iconImageView.heightAnchor.constraint(equalToConstant: 25),
            iconImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            iconImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),
            
            // Title label constraints
            titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: iconImageView.centerXAnchor),
            
            // Container view constraints
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -5)
        ])
    }
}

// MARK: - Gesture

extension TabBarItemView {
    func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        addGestureRecognizer(tapGesture)
    }
    
    @objc
    func handleGesture(_ sender: UITapGestureRecognizer) {
        delegate?.tapHandler(self)
    }
}

