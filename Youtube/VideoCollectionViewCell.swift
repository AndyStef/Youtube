//
//  VideoCollectionViewCell.swift
//  Youtube
//
//  Created by Andy Stef on 2/17/17.
//  Copyright © 2017 Andy Stef. All rights reserved.
//

import UIKit

class VideoCollectionViewCell: BaseCell {
    
    //Data model
    var video: Video? {
        didSet {
            titleLabel.text = video?.title
            
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let subtitleText = "\(video?.channel?.name ?? "") - \(numberFormatter.string(from: video?.numberOfViews ?? 0) ?? "") - 2 years ago"
            subtitleTextView.text = subtitleText
            //MARK: - those two definitely need some placeholder
            thumbnailImageView.image = UIImage(named: video?.thumbnailImageName ?? "")
            userProfileImageView.image = UIImage(named: video?.channel?.profileImageName ?? "")
            
            //estimate height of title label 
            if let title = video?.title {
                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
                
                print(estimatedRect.height)
                if estimatedRect.height > 20 {
                    titleLabelHeight = 44
                } else {
                    titleLabelHeight = 19
                }
            }
        }
    }

    //I write this just to test
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "taylor")

        //MARK: - A little trick
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        return imageView
    }()

    private let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.image = #imageLiteral(resourceName: "profile")
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Taylor Swift - Blank Space"
        label.numberOfLines = 2
        
        return label
    }()
    
    private var titleLabelHeight: CGFloat?

    private let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "TaylorSwiftVEVO - 1,604,684,607 views - 2 years ago"
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        textView.textColor = UIColor.lightGray
        textView.isEditable = false
        textView.isSelectable = false
        textView.isScrollEnabled = false

        return textView
    }()

    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    override func setupViews() {
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)

        //main image anchors
        thumbnailImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        thumbnailImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        thumbnailImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        //MARK: - this value doesn't have to be hardcodded
        thumbnailImageView.heightAnchor.constraint(equalToConstant: 230).isActive = true

        //separator anchors
        separatorView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        separatorView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 2).isActive = true

        //user image anchors
        userProfileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        userProfileImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        userProfileImageView.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 8).isActive = true
        userProfileImageView.widthAnchor.constraint(equalToConstant: 44).isActive = true

        //title anchors
        titleLabel.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 8).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 8).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: titleLabelHeight ?? 19).isActive = true

        //FIXME: - fix too long label name(video 4)
        //subtitle anchors
        subtitleTextView.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 8).isActive = true
        subtitleTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        subtitleTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
        subtitleTextView.heightAnchor.constraint(equalToConstant: 29).isActive = true
    }
}
