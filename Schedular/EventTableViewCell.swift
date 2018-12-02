//
//  EventTableViewCell.swift
//  Schedular
//
//  Created by Songyu Gu on 11/30/18.
//  Copyright © 2018 Songyu Gu. All rights reserved.
//



import UIKit

class EventTableViewCell: UITableViewCell {

    var titleLabel: UILabel!
//    var detailLabel: UILabel!
//    var locationLabel: UILabel!
    var importanceLabel: UILabel!
    
    let padding: CGFloat = 14
    let labelHeight: CGFloat = 16
    let titleHeight: CGFloat = 30
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        contentView.addSubview(titleLabel)
//
//        detailLabel = UILabel()
//        detailLabel.translatesAutoresizingMaskIntoConstraints = false
//        detailLabel.font = UIFont.systemFont(ofSize: 12)
//        contentView.addSubview(detailLabel)
//
//        locationLabel = UILabel()
//        locationLabel.translatesAutoresizingMaskIntoConstraints = false
//        locationLabel.font = UIFont.systemFont(ofSize: 12)
//        contentView.addSubview(locationLabel)
//
        importanceLabel = UILabel()
        importanceLabel.translatesAutoresizingMaskIntoConstraints = false
        importanceLabel.font = UIFont.systemFont(ofSize: 16)
        importanceLabel.textAlignment = .center
        contentView.addSubview(importanceLabel)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            titleLabel.heightAnchor.constraint(equalToConstant: titleHeight),
            ])
//        NSLayoutConstraint.activate([
//            detailLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: padding),
//            detailLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: padding),
//            detailLabel.heightAnchor.constraint(equalToConstant: labelHeight)
//            ])
//        NSLayoutConstraint.activate([
//            locationLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: padding),
//            locationLabel.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 2),
//            locationLabel.heightAnchor.constraint(equalToConstant: labelHeight)
//            ])
        NSLayoutConstraint.activate([
            importanceLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 10),
            importanceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            importanceLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            importanceLabel.widthAnchor.constraint(equalToConstant: 30)
            ])
        
    }
    func configure(for Event: Event) {
        titleLabel.text = Event.title
//        detailLabel.text = Event.detail
//        locationLabel.text = Event.location
        importanceLabel.text = Event.importance
        
    }
    
}
