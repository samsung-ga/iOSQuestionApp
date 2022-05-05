//
//  UIViewController+.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/05.
//

import Foundation
import UIKit

extension UIViewController {
    
    func animateWithKeyboard(_ notification: NSNotification, animation: (CGRect?, Double?) -> Void) {
        let frameKey         = UIResponder.keyboardFrameEndUserInfoKey
        let keyboardFrame    = (notification.userInfo?[frameKey] as? NSValue)?.cgRectValue
        
        let durationKey      = UIResponder.keyboardAnimationDurationUserInfoKey
        let keyboardDuration = notification.userInfo?[durationKey] as? Double
    
        animation(keyboardFrame, keyboardDuration)
    }

}
