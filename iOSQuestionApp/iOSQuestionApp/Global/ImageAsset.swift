//
//  ImageAsset.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/04/29.
//

import UIKit

enum ImageAsset: String {
    case swiftLogo
    case list_dash
    case gearshape
    case phone
    case moving
}

extension ImageAsset {
    var image: UIImage? {
        .init(named: self.rawValue)
    }
    
}
