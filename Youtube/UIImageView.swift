//
//  UIImageView.swift
//  Youtube
//
//  Created by Stef on 3/6/17.
//  Copyright © 2017 Andy Stef. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageUsing(urlString: String) {
        imageUrlString = urlString
        guard let url = URL(string: urlString) else { return }
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print("Something is wrong with loading image:", error)
                return
            }
            
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data)
                
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                self.image = imageToCache
            }
            
        }).resume()
    }
}
