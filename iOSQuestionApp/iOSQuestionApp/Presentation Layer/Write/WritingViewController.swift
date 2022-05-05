//
//  WritingViewController.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/05.
//

import UIKit

class WritingViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textView.becomeFirstResponder() // 더 자연스러움
    }
    
    override func setupAttribute() {
        super.setupAttribute()
        
        textView.delegate = self
        textView.layoutManager.delegate = self
        backButton.makeCorenerRadius(backButton.frame.height/2)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func pressCompleteButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func pressBackButton(_ sender: Any) {
        showBackAlertView {
            self.dismiss(animated: true)
        }
    }
    
    @IBOutlet weak var textViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var textCountLabel: UILabel!
}

// MARK: keyboard
extension WritingViewController {
    
    private func setupObserver() {
        let center = NotificationCenter.default
        
        center.addObserver(self,
                           selector: #selector(animateViewForKeyboardShow(_:)),
                           name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func animateViewForKeyboardShow(_ notification: NSNotification) {
        self.animateWithKeyboard(notification) { [weak self] keyboardFrame, keyboardDuration in
            guard let self = self                         else { return }
            guard let keyboardDuration = keyboardDuration else { return }
            guard let keyboardFrame = keyboardFrame else { return }
            
            textViewBottomConstraint.constant = keyboardFrame.height - DeviceInfo.bottomSafeAreaInset + 20
            
            UIView.animate(withDuration: keyboardDuration) { self.view.layoutIfNeeded() }
        }
    }
    
}

// MARK: NSLayoutManagerDelegate
extension WritingViewController: NSLayoutManagerDelegate {
    func layoutManager(_ layoutManager: NSLayoutManager, lineSpacingAfterGlyphAt glyphIndex: Int, withProposedLineFragmentRect rect: CGRect) -> CGFloat {
        return 4
    }
}

// MARK: UITextViewDelegate
extension WritingViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let isHidden = textView.text.isEmpty
        placeholderLabel.isHidden = !isHidden
        
        let count = calculateTextCount(textView.text)
        if count > 600 {
            textView.text = String(textView.text.prefix(600))
            showAlertView()
        }
        textCountLabel.text = "\(calculateTextCount(textView.text)) / 600"
    }
    
    private func calculateTextCount(_ text: String) -> Int {
        return text.count
    }
}

extension WritingViewController {
    
    private func showAlertView() {
        let alertViewController = UIAlertController(title: "경고 ⚠️", message: "600자 이하로 작성해주세요.", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "✅", style: .default)
        alertViewController.addAction(okButton)
        self.present(alertViewController, animated: true)
    }
    
    private func showBackAlertView(okHandler: @escaping ()->Void) {
        let alertViewController = UIAlertController(title: "알람 🚨", message: "나가시면 저장은 안돼요. 괜찮으신가요?", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "✅", style: .default) { _ in
            okHandler()
        }
        let cancelButton = UIAlertAction(title: "❌", style: .cancel)
        alertViewController.addAction(okButton)
        alertViewController.addAction(cancelButton)
        self.present(alertViewController, animated: true)
    }
}
