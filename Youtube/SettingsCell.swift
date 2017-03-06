//
//  SettingsCell.swift
//  Youtube
//
//  Created by Stef on 3/6/17.
//  Copyright © 2017 Andy Stef. All rights reserved.
//

import UIKit

class SettingsCell: BaseCell {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.darkGray : .white
            nameLabel.textColor = isHighlighted ? .white : .black
            icon.tintColor = isHighlighted ? .white : .black
        }
    }
  
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let icon: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.tintColor = .darkGray
        
        return image
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(icon)
        addSubview(nameLabel)
        
        icon.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        icon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 35).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        nameLabel.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 16).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 8).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
