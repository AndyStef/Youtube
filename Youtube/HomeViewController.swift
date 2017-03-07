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
        navigationController?.navigationBar.isTranslucent = false
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "   Home"
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
    
    //MARK: - maybe there is no need for delegate
    lazy var settingsLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeController = self
        
        return launcher
    }()
    
    @objc private func handleMoreTap() {
        settingsLauncher.showSettings()
    }
    
    func showControllerFor(setting: Setting) {
        let dummySettingsViewController = UIViewController()
        dummySettingsViewController.navigationItem.title = setting.name.rawValue
        dummySettingsViewController.view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .white
        //MARK: - that's the way to set color of navigation title
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationController?.pushViewController(dummySettingsViewController, animated: true)
    }
    
    private func setupMenuBar() {
        navigationController?.hidesBarsOnSwipe = true
        
        //MARK: - Actual trick to fill gap between status bar and menu bar
        let redView = UIView()
        redView.translatesAutoresizingMaskIntoConstraints = false
        redView.backgroundColor = UIColor(colorLiteralRed: 230/255, green: 32/255, blue: 31/255, alpha: 1)
        view.addSubview(redView)
        redView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        redView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        redView.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        redView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        view.addSubview(menuBar)
        menuBar.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        //MARK: - we need topLayoutGuide to stick to top of screen
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
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
        //FIXME: - it's totally broken on other iPhones
        let finalHeight = basicHeightForImage + 8 + 8 + 19 + 29 + 22

        return CGSize(width: width, height: finalHeight)
    }

    //MARK: Not sure if this is neccessary
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //MARK: - networking - it should definitely be in separate class
    private func fetchVideos() {
        ApiService.sharedInstance.fetchVideos { (videos) in
            self.videos = videos
            self.collectionView?.reloadData()
        }
    }
}
