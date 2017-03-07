//
//  ApiService.swift
//  Youtube
//
//  Created by Stef on 3/7/17.
//  Copyright © 2017 Andy Stef. All rights reserved.
//

import Foundation

class ApiService: NSObject {
    static let sharedInstance = ApiService()
    
    func fetchVideos(completion: @escaping ( [Video])->()) {
        let urlString = "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error:", error.localizedDescription)
            }
            
            guard let data = data else {
                print("Error: cannot get data")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                
                var videos = [Video]()
                
                for dictionary in json as! [[String: Any]] {
                    let video = Video()
                    video.title = dictionary["title"] as? String
                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                    
                    let channelDictionary = dictionary["channel"] as? [String: Any]
                    let channel = Channel()
                    channel.name = channelDictionary?["name"] as? String
                    channel.profileImageName = channelDictionary?["profile_image_name"] as? String
                    
                    video.channel = channel
                    videos.append(video)
                }
                
                //MARK: - what is better this or to do in didSet
                DispatchQueue.main.async {
                    completion(videos)
                }
                
            } catch let jsonError {
                print("Error parsing json", jsonError.localizedDescription)
                return
            }
        }
        
        dataTask.resume()
    }
}
