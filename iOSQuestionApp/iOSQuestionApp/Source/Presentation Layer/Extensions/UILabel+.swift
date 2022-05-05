//
//  UILabel+.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/05.
//

import UIKit

extension UILabel {
    /// height: Point간격
    func setupLineSpacing(_ height: CGFloat, alignment: NSTextAlignment = .left) {
        let attrString = NSMutableAttributedString(string: self.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = height
        paragraphStyle.alignment = alignment
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        self.attributedText = attrString
    }
}
