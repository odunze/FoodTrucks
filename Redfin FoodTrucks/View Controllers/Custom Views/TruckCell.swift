//
//  TruckCell.swift
//  Redfin FoodTrucks
//
//  Created by Lotanna Igwe-Odunze on 6/20/20.
//  Copyright © 2020 Lotanna Igwe-Odunze. All rights reserved.
//

import UIKit

class TruckCell: UITableViewCell {
    
    var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 5
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont(name: "Helvetica-Bold", size: 16.0)
        return label
    }()
    
    var addressLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Helvetica", size: 14.0)
        return label
    }()
    
    var menuLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 5
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont(name: "Helvetica", size: 12.0)
        return label
    }()
    
    var timeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Helvetica", size: 14.0)
        label.textAlignment = .center
        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return label
    }()
    
    var hozStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 4.0
        stack.alignment = .top
        return stack
    }()
    
    var vertStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        stack.spacing = 2.0
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //translatesAutoresizingMaskIntoConstraints = false
        
        hozStack.addArrangedSubview(menuLabel)
        hozStack.addArrangedSubview(timeLabel)
        
        vertStack.addArrangedSubview(nameLabel)
        vertStack.addArrangedSubview(addressLabel)
        vertStack.addArrangedSubview(hozStack)
        
        contentView.addSubview(vertStack)
        
        NSLayoutConstraint.activate([
            vertStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            vertStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vertStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            vertStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
