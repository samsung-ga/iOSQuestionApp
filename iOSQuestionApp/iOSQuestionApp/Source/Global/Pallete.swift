//
//  Color.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/04/29.
//

import UIKit

enum Pallete: String {
    case main
    case point
    case red
    case blue
    case gray
    case white
    case black
}

extension Pallete {
    var color: UIColor? {
        return .init(named: self.rawValue)
    }
}

//struct Pallete {
//    static let main     = UIColor(named: "mainColor")
//    static let point    = UIColor(named: "pointColor")
//    static let red      = UIColor(named: "redColor")
//    static let blue     = UIColor(named: "blueColor")
//    static let gray     = UIColor(named: "grayColor")
//}
