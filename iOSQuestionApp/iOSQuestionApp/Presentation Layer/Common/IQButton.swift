//
//  IQButton.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/04.
//

import UIKit

/// 높이 52 고정된 버튼
final class IQButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        setupAttribute()
        setupLayout()
        addTarget(self, action: #selector(touchDownAnimation), for: .touchDown)
        addTarget(self, action: #selector(touchUpAnimation), for: .touchUpInside)
        addTarget(self, action: #selector(touchUpAnimation), for: .touchUpOutside)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension IQButton {
    func setupTitle(_ title: String) {
        self.setTitle(title, for: .normal)
    }
}

extension IQButton {
    private func setupAttribute() {
        self.titleLabel?.font = .boldSystemFont(ofSize: 15)
        self.backgroundColor = Pallete.blue.color
        self.layer.cornerRadius = 26
        self.setTitleColor(Pallete.white.color, for: .normal)
    }
    
    private func setupLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 52)
        ])
    }
    
    
    @objc private func touchDownAnimation(sender: UIButton) {
        UIView.animate(withDuration: 0.25){
            sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
    }
    
    @objc private func touchUpAnimation(sender: UIButton) {
        UIView.animate(withDuration: 0.15){
            sender.transform = .identity
        }
    }
    
}
