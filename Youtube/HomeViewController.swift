//
//  MainViewController.swift
//  Youtube
//
//  Created by Andy Stef on 2/17/17.
//  Copyright © 2017 Andy Stef. All rights reserved.
//

import UIKit

class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var videos: [Video] = {
        let kanyeChannel = Channel()
        kanyeChannel.name = "KanyeIsTheBestChannel"
        kanyeChannel.profileImageName = ""
        
        let blankSpaceVideo = Video()
        blankSpaceVideo.title = "Taylor Swift - Blank Space"
        blankSpaceVideo.thumbnailImageName = "taylor"
        blankSpaceVideo.channel = kanyeChannel
        blankSpaceVideo.numberOfViews = 28374194
        
        let badBloodVideo = Video()
        badBloodVideo.title = "Taylor Swift - Bad Blood featuring Kendrick Lamargdsgdsgsdgsdgsdgsdgsdgsd"
        badBloodVideo.thumbnailImageName = "BadBloodImage"
        badBloodVideo.channel = kanyeChannel
        badBloodVideo.numberOfViews = 124125662125
        
        return [blankSpaceVideo, badBloodVideo]
    }()

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
    }

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
        
    }
    
    @objc private func handleMoreTap() {
        
    }

    private func setupMenuBar() {
        view.addSubview(menuBar)
        menuBar.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        menuBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        menuBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        menuBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellId.homeCellId, for: indexPath) as? VideoCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.video = videos[indexPath.item]

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //What is better here bounds or frame????? brian put frame here
        let width = view.bounds.width
        let basicHeightForImage = (width - 32) * 9 / 16
        //MARK: - Basically these magic numbers is not that i want
        let finalHeight = basicHeightForImage + 8 + 8 + 19 + 29 + 22

        return CGSize(width: width, height: finalHeight)
    }

    //MARK: Not sure if this is neccessary
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
