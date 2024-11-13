//
//  TopView.swift
//  CL-Programming-Session
//
//  Created by Samuel Garcia on 13-11-24.
//

import UIKit

class TopView: UIView, CustomViewContainer {
    var products: [Product]? {
        didSet {
            collectionView.reloadData()
        }
    }

    lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.itemSize = CGSize(width: frame.height, height: frame.height)
        return collectionViewLayout
    }()

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.collectionViewLayout)
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.reusableIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        return collectionView
    }()

    func viewRotated(to orientation: ViewOrientation) {
        debugPrint(orientation)
        if(orientation == .portrait){
            self.collectionViewLayout.itemSize = CGSize(width: self.frame.width * 0.8, height: self.frame.height)
            setNeedsLayout()
            return
        }
        self.collectionViewLayout.itemSize = CGSize(width: self.frame.width * 0.2 , height: self.frame.height)
        setNeedsLayout()
    }
}

extension TopView: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.reusableIdentifier, for: indexPath) as? ProductCell else {
            return UICollectionViewCell()
        }
        cell.product = products?[indexPath.row]
        return cell
    }
}
