//
//  BaseViewController.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/04.
//

import UIKit
import Combine

class BaseViewController: UIViewController, CodeBasedView {
    
    var cancelBag = Set<AnyCancellable>()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAttribute()
        setupLayout()
        bind()
    }
    
    func setupAttribute() {
        view.backgroundColor = Pallete.main.color
    }
    func setupLayout() { }
    
    func bind() { }
}
