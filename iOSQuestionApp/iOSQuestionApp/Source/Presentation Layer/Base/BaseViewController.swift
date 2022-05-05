//
//  BaseViewController.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/04.
//

import UIKit

class BaseViewController: UIViewController, CodeBasedView {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAttribute()
        setupLayout()
    }
    
    func setupAttribute() {
        view.backgroundColor = Pallete.main.color
    }
    func setupLayout() { }
}
