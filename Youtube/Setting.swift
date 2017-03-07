//
//  Setting.swift
//  Youtube
//
//  Created by Stef on 3/7/17.
//  Copyright © 2017 Andy Stef. All rights reserved.
//

import Foundation

class Setting: NSObject {
    let name: SettingName
    let imageName: String
    
    init(name: SettingName, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}

enum SettingName: String {
    case settings = "Settings"
    case terms = "Terms & privacy policy"
    case help = "Help"
    case feedback = "Send Feedback"
    case account = "Switch Account"
    case cancel = "Cancel"
}
