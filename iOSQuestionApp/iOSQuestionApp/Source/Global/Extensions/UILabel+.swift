//
//  UILabel+.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/05.
//

import UIKit

extension UILabel {
    /// height: Point간격
    func setupLineSpacing(_ height: CGFloat) {
        let attrString = NSMutableAttributedString(string: self.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = height
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        self.attributedText = attrString
    }
}
