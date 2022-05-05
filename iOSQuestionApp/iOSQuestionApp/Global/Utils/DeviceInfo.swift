//
//  DeviceInfo.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/05.
//

import UIKit

struct DeviceInfo {
    static var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    static var bottomSafeAreaInset: CGFloat {
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        
        return keyWindow?.safeAreaInsets.bottom ?? 0
    }
}
