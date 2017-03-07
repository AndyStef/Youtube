//
//  Setting.swift
//  Youtube
//
//  Created by Stef on 3/7/17.
//  Copyright © 2017 Andy Stef. All rights reserved.
//

import Foundation

class Setting: NSObject {
    let name: String
    let imageName: String
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}
