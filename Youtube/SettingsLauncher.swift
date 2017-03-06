//
//  SettingsLauncher.swift
//  Youtube
//
//  Created by Stef on 3/6/17.
//  Copyright © 2017 Andy Stef. All rights reserved.
//

import UIKit

class SettingsLauncher: NSObject {
    
    let blackView = UIView()
    
    func showSettings() {
        //TODO: implement this
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = .black
            blackView.alpha = 0.0
            blackView.frame = window.bounds
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            window.addSubview(blackView)
            
            UIView.animate(withDuration: 1.0, animations: {
                self.blackView.alpha = 0.5
            })
        }
    }
    
    func handleDismiss() {
        UIView.animate(withDuration: 1.0) {
            self.blackView.alpha = 0.0
        }
    }
    
    override init() {
        super.init()
    }
}
