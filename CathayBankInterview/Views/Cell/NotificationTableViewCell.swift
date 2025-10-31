//
//  File.swift
//  CathayBankInterview
//
//  Created by Wei Chu on 2025/10/28.
//

import Foundation
import UIKit

class NotificationTableViewCell: UITableViewCell {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setConstraint()
    }
    
    private let statusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .orange
        imageView.layer.cornerRadius = 6
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray700
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupViews() {
        let viewsToAdd: [UIView] = [
            statusImageView,
            titleLabel,
            timeLabel,
            contentLabel,
        ]
        viewsToAdd.forEach { contentView.addSubview($0) }
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
            statusImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            statusImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            statusImageView.heightAnchor.constraint(equalToConstant: 12),
            statusImageView.widthAnchor.constraint(equalToConstant: 12),
            
            titleLabel.leadingAnchor.constraint(equalTo: statusImageView.trailingAnchor, constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: statusImageView.centerYAnchor),
            
            timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            contentLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor),
            contentLabel.leadingAnchor.constraint(equalTo: timeLabel.leadingAnchor),
            contentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            contentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    func configure(notificationArray: NotificationModel) {
        statusImageView.isHidden = notificationArray.status
        titleLabel.text = notificationArray.title
        timeLabel.text = notificationArray.updateDateTime
        contentLabel.text = notificationArray.message
    }
}
