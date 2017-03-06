//
//  UIImageView.swift
//  Youtube
//
//  Created by Stef on 3/6/17.
//  Copyright © 2017 Andy Stef. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadImageUsing(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print("Something is wrong with loading image:", error)
                return
            }
            
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
            
        }).resume()
    }
}
