//
//  MainViewController.swift
//  Youtube
//
//  Created by Andy Stef on 2/17/17.
//  Copyright © 2017 Andy Stef. All rights reserved.
//

import UIKit

class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {    
    private var videos: [Video]? {
        didSet {
           // collectionView?.reloadData()
        }
    }

    private struct CellId {
        static let homeCellId = "HomeCellId"
    }

    let menuBar: MenuBar = {
        let bar = MenuBar()
        bar.translatesAutoresizingMaskIntoConstraints = false

        return bar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customizeNavigationBar()
        setupCollectionView()
        setupMenuBar()
        setupNavBarButtons()
        fetchVideos()
    }

    //MARK: - UI stuff
    private func customizeNavigationBar() {
        navigationItem.title = "Home"
        navigationController?.navigationBar.isTranslucent = false
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
    }

    private func setupCollectionView() {
        collectionView?.backgroundColor = .white
        collectionView?.contentInset = UIEdgeInsets(top: 50.0, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50.0, left: 0, bottom: 0, right: 0)
        collectionView?.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: CellId.homeCellId)
    }
    
    private func setupNavBarButtons() {
        let glassImage = UIImage(named: "searchIco")?.withRenderingMode(.alwaysTemplate)
        let searchButton = UIBarButtonItem(image: glassImage, style: .plain, target: self, action: #selector(handleSearchTap))
        searchButton.tintColor = .white
        
        let moreImage = UIImage(named: "more-vert")?.withRenderingMode(.alwaysTemplate)
        let moreButton = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handleMoreTap))
        moreButton.tintColor = .white
        
        navigationItem.rightBarButtonItems = [moreButton, searchButton]
    }
    
    @objc private func handleSearchTap() {
        //TODO: implement this
    }
    
    let settingsLauncher = SettingsLauncher()
    
    @objc private func handleMoreTap() {
        settingsLauncher.showSettings()
    }
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        menuBar.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        menuBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        menuBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        menuBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    }
    
    //MARK: - Collection View stuff
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellId.homeCellId, for: indexPath) as? VideoCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.video = videos?[indexPath.item]

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //What is better here bounds or frame????? brian put frame here
        let width = view.bounds.width
        let basicHeightForImage = (width - 32) * 9 / 16
        //MARK: - Basically these magic numbers is not that i want
        //FIXME: - fix too long label name(video 4)
        let finalHeight = basicHeightForImage + 8 + 8 + 19 + 29 + 22

        return CGSize(width: width, height: finalHeight)
    }

    //MARK: Not sure if this is neccessary
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //MARK: - networking - it should definitely be in separate class
    private func fetchVideos() {
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
                
                self.videos = [Video]()
                
                for dictionary in json as! [[String: Any]] {
                    let video = Video()
                    video.title = dictionary["title"] as? String
                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                    
                    let channelDictionary = dictionary["channel"] as? [String: Any]
                    let channel = Channel()
                    channel.name = channelDictionary?["name"] as? String
                    channel.profileImageName = channelDictionary?["profile_image_name"] as? String
                    
                    video.channel = channel
                    self.videos?.append(video)
                }
                
                //MARK: - what is better this or to do in didSet
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
                
            } catch let jsonError {
                print("Error parsing json", jsonError.localizedDescription)
                return
            }
            
        }
        
        dataTask.resume()
    }
}
