//
//  UICollectionView+.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/05.
//

import UIKit

extension UICollectionView {
    
    func registerWithNib<CollectionViewCell: UICollectionViewCell>(_ cellType: CollectionViewCell.Type) {
        let cellName = String(describing: cellType)
        let nibData = UINib(nibName: String(describing: cellName), bundle: nil)
        self.register(nibData, forCellWithReuseIdentifier: cellName)
    }
    
    func dequeueReusableCell<CollectionViewCell: UICollectionViewCell>(_ cellType: CollectionViewCell.Type,
                                                                       for indexPath: IndexPath) -> CollectionViewCell? {
        let identifier = String(describing: cellType)
        return self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? CollectionViewCell
    }
}
