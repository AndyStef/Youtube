//
//  MainViewController.swift
//  Youtube
//
//  Created by Andy Stef on 2/17/17.
//  Copyright © 2017 Andy Stef. All rights reserved.
//

import UIKit

class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private struct CellId {
        static let homeCellId = "HomeCellId"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Home"
        collectionView?.backgroundColor = .white
        collectionView?.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: CellId.homeCellId)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellId.homeCellId, for: indexPath)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //What is better here bounds or frame????? brian put frame here
        let width = view.bounds.width

        return CGSize(width: width, height: 200)
    }

    //MARK: Not sure if this is neccessary
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
