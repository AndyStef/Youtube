//
//  MenuBar.swift
//  Youtube
//
//  Created by Andy Stef on 2/27/17.
//  Copyright © 2017 Andy Stef. All rights reserved.
//

import UIKit

class MenuBar: UIView {

    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(colorLiteralRed: 230/255, green: 32/255, blue: 31/255, alpha: 1)
        collectionView.delegate = self
        collectionView.dataSource = self

        return collectionView
    }()

    fileprivate let cellId = "cellId"
    fileprivate let imageNames = ["home", "fire", "collection", "user"]

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupCollectionView()
        selectFirstCell()
    }

    private func setupCollectionView() {
        collectionView.register(MenuBarCollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }

    private func selectFirstCell() {
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .top)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - UICollectionView DataSource, Delegate, DelegateFlowLayout
extension MenuBar: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    //MARK: dataSource methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? MenuBarCollectionViewCell else {

            return UICollectionViewCell()
        }

        cell.imageView.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)

        return cell
    }

    //MARK: sizing methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = bounds.height
        let width = bounds.width / 4

        return CGSize(width: width, height: height)
    }

    //spacing between cells in 1 section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
