//
//  BaseCollectionView.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/05.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell, CodeBasedView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupAttribute()
        setupLayout()
    }
    
    func setupAttribute() { }
    func setupLayout() { }
}
