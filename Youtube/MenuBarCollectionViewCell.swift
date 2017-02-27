//
//  MenuBarCollectionViewCell.swift
//  Youtube
//
//  Created by Andy Stef on 2/27/17.
//  Copyright © 2017 Andy Stef. All rights reserved.
//

import UIKit

class MenuBarCollectionViewCell: BaseCell {

    //this really should be private
    let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = UIColor.black

        return image
    }()

    override var isHighlighted: Bool {
        didSet {
            imageView.tintColor = isHighlighted ? .white : .black
        }
    }

    override var isSelected: Bool {
        didSet {
            imageView.tintColor = isSelected ? .white : .black
        }
    }

    override func setupViews() {
        super.setupViews()

        addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 28.0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 28.0).isActive = true
    }
}
