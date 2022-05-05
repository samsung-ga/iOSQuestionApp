//
//  UIView+.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/04/29.
//

import UIKit

extension UIView {
    
    func addShadowEffect() {
        self.layer.shadowColor = self.backgroundColor?.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = self.layer.cornerRadius
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowPath = nil
    }
    
    func makeCorenerRadius(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    
    func makeBorderLayer(_ color: UIColor?, _ width: CGFloat) {
        self.layer.borderColor = color?.cgColor
        self.layer.borderWidth = width
    }
}
