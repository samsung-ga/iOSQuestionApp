//
//  File.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/05.
//

import UIKit

protocol ShakePopupDelegate: AnyObject {
    func dismissPopup()
    func presentWritingViewController()
}

extension ShakePopupDelegate {
    func dismissPopup() { }
    func presentWritingViewController() { }
}

class ShakePopupViewController: BaseViewController {
    
    weak var delegate: ShakePopupDelegate?
    
    override func setupAttribute() {
        containerView.makeCorenerRadius(26)
        containerView.makeBorderLayer(Pallete.white.color, 1)
        
        guideLabel.setupLineSpacing(10, alignment: .center)
    }
    
    @IBAction func pressBackButton(_ sender: Any) {
        delegate?.dismissPopup()
        self.dismiss(animated: true)
    }
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var guideLabel: UILabel!
    
    // MARK: For Shake Interaction
    let generator = UIImpactFeedbackGenerator(style: .heavy)
}

extension ShakePopupViewController {
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        super.motionEnded(motion, with: event)
        if event?.subtype == .motionShake {
            generator.impactOccurred()
            
            delegate?.dismissPopup()
            
            self.dismiss(animated: false) { [weak self] in
                self?.delegate?.presentWritingViewController()
            }
        }
    }
}
