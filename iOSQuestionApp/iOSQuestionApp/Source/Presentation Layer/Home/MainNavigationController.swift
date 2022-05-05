//
//  MainNavigationController.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/05.
//

import UIKit

class MainNavigationController: UINavigationController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = Pallete.main.color
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: Pallete.white.color!]
        self.navigationBar.standardAppearance = navigationBarAppearance
        self.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        
        self.navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
    
    #if DEBUG
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        super.motionEnded(motion, with: event)
        if event?.subtype == .motionShake {
            let test = HapticTetViewController()
            self.present(test, animated: true)
        }
    }
    #endif
}
