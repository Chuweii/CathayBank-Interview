//
//  File.swift
//  CathayBankInterview
//
//  Created by Wei Chu on 2024/8/21.
//

import Foundation
import UIKit

class BalanceAccountView: UIView {
    private var isShowAmount: Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupViews()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "My Account Balance"
        label.textColor = .gray100
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let eyeButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "iconEye01On")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let usdTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "USD"
        label.textColor = .gray300
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let usdSubTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "loaging..."
        label.textColor = .gray500
        label.font = .systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let usdSubHideTiteLabel: UILabel = {
        let label = UILabel()
        label.text = "********"
        label.isHidden = true
        label.font = .systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let khrTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "KHR"
        label.textColor = .gray300
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let khrSubTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "loaging..."
        label.textColor = .gray500
        label.font = .systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let khrSubHideTiteLabel: UILabel = {
        let label = UILabel()
        label.text = "********"
        label.isHidden = true
        label.font = .systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - setup

    private func setupViews() {
        addSubview(titleLabel)
        addSubview(eyeButton)
        addSubview(usdTitleLabel)
        addSubview(usdSubTitleLabel)
        addSubview(usdSubHideTiteLabel)
        addSubview(khrTitleLabel)
        addSubview(khrSubTitleLabel)
        addSubview(khrSubHideTiteLabel)
        eyeButton.addTarget(self, action: #selector(eyeAmountAction), for: .touchUpInside)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            
            eyeButton.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 8),
            eyeButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            eyeButton.heightAnchor.constraint(equalToConstant: 24),
            eyeButton.widthAnchor.constraint(equalToConstant: 24),
            
            usdTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            usdTitleLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            
            // show
            usdSubTitleLabel.topAnchor.constraint(equalTo: usdTitleLabel.bottomAnchor),
            usdSubTitleLabel.leftAnchor.constraint(equalTo: usdTitleLabel.leftAnchor),
            usdSubTitleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
            
            // hide
            usdSubHideTiteLabel.topAnchor.constraint(equalTo: usdTitleLabel.bottomAnchor),
            usdSubHideTiteLabel.leftAnchor.constraint(equalTo: usdTitleLabel.leftAnchor),
            usdSubHideTiteLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
            
            // show
            khrTitleLabel.topAnchor.constraint(equalTo: usdSubTitleLabel.bottomAnchor, constant: 8),
            khrTitleLabel.leftAnchor.constraint(equalTo: usdSubTitleLabel.leftAnchor),
            
            // hide
            khrSubTitleLabel.topAnchor.constraint(equalTo: khrTitleLabel.bottomAnchor),
            khrSubTitleLabel.leftAnchor.constraint(equalTo: khrTitleLabel.leftAnchor),
            khrSubTitleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
            khrSubTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            khrSubHideTiteLabel.topAnchor.constraint(equalTo: khrTitleLabel.bottomAnchor),
            khrSubHideTiteLabel.leftAnchor.constraint(equalTo: khrTitleLabel.leftAnchor),
            khrSubHideTiteLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
            khrSubHideTiteLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
    }
    
    @objc
    func eyeAmountAction() {
        if isShowAmount {
            let image = UIImage(named: "iconEye02Off")
            eyeButton.setImage(image, for: .normal)
            isShowAmount = false
            
            usdSubTitleLabel.isHidden = true
            khrSubTitleLabel.isHidden = true
            
            usdSubHideTiteLabel.isHidden = false
            khrSubHideTiteLabel.isHidden = false
        } else {
            let image = UIImage(named: "iconEye01On")
            eyeButton.setImage(image, for: .normal)
            isShowAmount = true
            
            usdSubTitleLabel.isHidden = false
            khrSubTitleLabel.isHidden = false
            
            usdSubHideTiteLabel.isHidden = true
            khrSubHideTiteLabel.isHidden = true
        }
    }
    
    func configure(usdTotal: String, khrTotal: String) {
        usdSubTitleLabel.text = usdTotal
        khrSubTitleLabel.text = khrTotal
    }
}
