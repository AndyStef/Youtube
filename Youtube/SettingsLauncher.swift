//
//  SettingsLauncher.swift
//  Youtube
//
//  Created by Stef on 3/6/17.
//  Copyright © 2017 Andy Stef. All rights reserved.
//

import UIKit

class SettingsLauncher: NSObject {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        
        return collectionView
    }()
    
    let collectionViewHeight: CGFloat = 200.0
    
    let blackView = UIView()
    
    func showSettings() {
        //TODO: implement this
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = .black
            blackView.alpha = 0.0
            blackView.frame = window.bounds
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            window.addSubview(blackView)
            window.addSubview(collectionView)
           
            let y = window.frame.height// - collectionViewHeight
            collectionView.frame = CGRect(x: 0, y: y, width: window.frame.width, height: collectionViewHeight)
            
            UIView.animate(withDuration: 1.0, animations: {
                self.blackView.alpha = 0.5
                self.collectionView.frame.origin.y -= self.collectionViewHeight
            })
        }
    }
    
    func handleDismiss() {
        UIView.animate(withDuration: 1.0) {
            self.blackView.alpha = 0.0
            self.collectionView.frame.origin.y += self.collectionViewHeight
        }
    }
    
    override init() {
        super.init()
    }
}
