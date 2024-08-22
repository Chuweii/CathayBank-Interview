//
//  File.swift
//  CathayBankInterview
//
//  Created by Wei Chu on 2024/8/21.
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
        statusImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(22)
            make.leading.equalTo(contentView.snp.leading).offset(16)
            make.height.width.equalTo(12)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(statusImageView.snp.trailing).offset(4)
            make.trailing.equalTo(contentView.snp.trailing)
            make.centerY.equalTo(statusImageView.snp.centerY)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(titleLabel.snp.trailing)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom)
            make.leading.equalTo(timeLabel.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing).offset(-32)
            make.bottom.equalTo(contentView.snp.bottom).offset(-16)
        }
    }
    
    func configure(notificationArray: NotificationModel) {
        statusImageView.isHidden = notificationArray.status
        titleLabel.text = notificationArray.title
        timeLabel.text = notificationArray.updateDateTime
        contentLabel.text = notificationArray.message
    }
}
