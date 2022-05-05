//
//  ViewController.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/04/29.
//

import UIKit

final class HomeViewController: BaseViewController {
    
    override func setupLayout() {
        super.setupLayout()
        
        view.addSubview(questionContainerView)
        NSLayoutConstraint.activate([
            questionContainerView.topAnchor.constraint(equalTo: guideLabel.bottomAnchor, constant: 100),
            questionContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            questionContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 29),
            questionContainerView.widthAnchor.constraint(equalTo: questionContainerView.heightAnchor, multiplier: 332/185),
        ])
        
        view.addSubview(questionGuideLabel)
        NSLayoutConstraint.activate([
            questionGuideLabel.topAnchor.constraint(equalTo: questionContainerView.topAnchor, constant: 32),
            questionGuideLabel.centerXAnchor.constraint(equalTo: questionContainerView.centerXAnchor)
        ])
        view.addSubview(questionView)
        NSLayoutConstraint.activate([
            questionView.topAnchor.constraint(equalTo: questionGuideLabel.bottomAnchor, constant: 15),
            questionView.centerXAnchor.constraint(equalTo: questionGuideLabel.centerXAnchor),
            questionView.widthAnchor.constraint(equalToConstant: 89),
            questionView.heightAnchor.constraint(equalToConstant: 89)
        ])
        questionView.addSubview(questionCountLabel)
        NSLayoutConstraint.activate([
            questionCountLabel.centerXAnchor.constraint(equalTo: questionView.centerXAnchor),
            questionCountLabel.centerYAnchor.constraint(equalTo: questionView.centerYAnchor)
        ])
        view.addSubview(iqButton)
        NSLayoutConstraint.activate([
            iqButton.topAnchor.constraint(equalTo: questionContainerView.bottomAnchor, constant: 33),
            //            iqButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -33),
            iqButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            iqButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 29),
        ])
    }
    
    override func setupAttribute() {
        super.setupAttribute()
        
        questionContainerView.backgroundColor = Pallete.point.color
        questionContainerView.makeCorenerRadius(Constant.cornerRadius)
        
        questionGuideLabel.text = "답변한 질문 개수"
        questionGuideLabel.textColor = Pallete.white.color
        questionGuideLabel.font = UIFont.boldSystemFont(ofSize: 15)
        
        questionView.backgroundColor = Pallete.red.color
        questionView.makeCorenerRadius(Constant.cornerRadius)
        questionView.addShadowEffect()
        
        questionCountLabel.text = "12"
        questionCountLabel.textColor = Pallete.white.color
        questionCountLabel.font = UIFont.boldSystemFont(ofSize: 34)
        
        iqButton.setupTitle("랜덤 답변하러 가기")
        iqButton.addTarget(self, action: #selector(pressIQButton), for: .touchUpInside)
    }
    
    @IBAction func pressListBarButton(_ sender: Any) {
        let viewControllerName = String(describing: ListViewController.self)
        let storyboard = UIStoryboard(name: viewControllerName, bundle: nil)
        guard let listViewController = storyboard.instantiateViewController(withIdentifier: viewControllerName) as? ListViewController else {
            fatalError()
        }
        self.navigationController?.pushViewController(listViewController, animated: true)
    }
    
    @IBAction func pressSettingBarButton(_ sender: Any) {
        let viewControllerName = String(describing: SettingViewController.self)
        let storyboard = UIStoryboard(name: viewControllerName, bundle: nil)
        guard let settingViewController = storyboard.instantiateViewController(withIdentifier: viewControllerName) as? SettingViewController else {
            fatalError()
        }
        self.navigationController?.pushViewController(settingViewController, animated: true)
    }
    
    @objc private func pressIQButton() {
        setupBackgroundView()
        animateBackgroundView(to: true)
        let viewControllerName = String(describing: ShakePopupViewController.self)
        let storyboard = UIStoryboard(name: viewControllerName, bundle: nil)
        guard let shakePopupViewController = storyboard.instantiateViewController(withIdentifier: viewControllerName) as? ShakePopupViewController else {
            fatalError()
        }
        shakePopupViewController.delegate = self
        shakePopupViewController.modalTransitionStyle = .crossDissolve
        shakePopupViewController.modalPresentationStyle = .overCurrentContext
        self.present(shakePopupViewController, animated: true)
    }
    
    @IBOutlet weak var guideLabel: UILabel!
    private lazy var questionContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var questionGuideLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var questionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var questionCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var iqButton: IQButton = {
        let button = IQButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
}

extension HomeViewController {
    
    private func setupBackgroundView() {
        view.addSubview(backgroundView)
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        backgroundView.backgroundColor = Pallete.black.color
        backgroundView.alpha = 0
    }
    
    private func animateBackgroundView(to direction: Bool) {
        let duration: TimeInterval = direction ? 0.35 : 0.15
        let alpha: CGFloat = direction ? 0.6 : 0.0
        let naviBarAlpha: CGFloat = direction ? 0.4 : 1
        
        UIView.animate(withDuration: duration) {
            self.backgroundView.alpha = alpha
            self.navigationController?.navigationBar.alpha = naviBarAlpha
        }
        
        if !direction { backgroundView.removeFromSuperview() }
    }
}

// MARK: ShakePopupDelegate
extension HomeViewController: ShakePopupDelegate {
    func dismissPopup() {
        animateBackgroundView(to: false)
    }
    
    func presentWritingViewController() {
        
        let viewControllerName = String(describing: WritingViewController.self)
        let storyboard = UIStoryboard(name: viewControllerName, bundle: nil)
        guard let writingViewController = storyboard.instantiateViewController(withIdentifier: viewControllerName) as? WritingViewController else {
            fatalError()
        }
        writingViewController.modalPresentationStyle = .fullScreen
        self.present(writingViewController, animated: true)
    }
}
