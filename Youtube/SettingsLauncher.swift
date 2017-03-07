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
    
    let collectionViewHeight: CGFloat = 300.0
    let settings: [Setting] = {
        let settings = [Setting(name: "Settings", imageName: "settings"),
                        Setting(name: "Terms & privacy policy", imageName: "lock"),
                        Setting(name: "Send Feedback", imageName: "feedback"),
                        Setting(name: "Help", imageName: "help"),
                        Setting(name: "Switch Account", imageName: "account"),
                        Setting(name: "Cancel", imageName: "close")]
        
        return settings
    }()
    
    //MARK: - storyboard
    let cellId = "cellId"
    
    let blackView = UIView()
    
    //MARK: - this should be weak and done with delegete protocol
    var homeController: HomeViewController?
    
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
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SettingsCell.self, forCellWithReuseIdentifier: cellId)
    }
}

extension SettingsLauncher: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? SettingsCell else {
            return UICollectionViewCell()
        }

        let setting = settings[indexPath.item]
        cell.setting = setting
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO: - implement this
        UIView.animate(withDuration: 0.6, animations: { 
            self.blackView.alpha = 0.0
            self.collectionView.frame.origin.y += self.collectionViewHeight
        }) { (completed) in
            let setting = self.settings[indexPath.item]
            
            if setting.name == "Cancel" {
                return
            }
            
            self.homeController?.showControllerFor(setting: setting)
        }
    }
    
    //MARK: - Sizing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    //MARK: - this is to minimize gap between cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
