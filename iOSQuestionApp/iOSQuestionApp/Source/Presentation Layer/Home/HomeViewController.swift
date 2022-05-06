//
//  ViewController.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/04/29.
//

import UIKit
import SpriteKit

final class HomeViewController: BaseViewController {
    
    let viewModel = HomeViewModel(AnswerNumberUseCase(QuestionRepository()), AnswerExistenceUseCase(TodayAnswerRepository()))
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear.send(Void())
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        view.addSubview(swiftSceneContainerView)
        swiftSceneContainerView.frame = calculateSwiftSceneFrame()
        
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
//            iqButton.topAnchor.constraint(equalTo: questionContainerView.bottomAnchor, constant: 33),
            iqButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -25),
            iqButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            iqButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 29),
        ])
        
        // TODO: 공사가 필요한 코드
        setupSwiftScene()
    }
    
    override func setupAttribute() {
        super.setupAttribute()
        
        guideLabel.setupLineSpacing(4, alignment: .center)
        
        questionContainerView.backgroundColor = Pallete.point.color
        questionContainerView.makeCorenerRadius(Constant.cornerRadius)
        
        questionGuideLabel.text = "답변한 질문 개수"
        questionGuideLabel.textColor = Pallete.white.color
        questionGuideLabel.font = UIFont.boldSystemFont(ofSize: 17)
        
        questionView.backgroundColor = Pallete.red.color
        questionView.makeCorenerRadius(Constant.cornerRadius)
        questionView.addShadowEffect()
        
        questionCountLabel.text = "12"
        questionCountLabel.textColor = Pallete.white.color
        questionCountLabel.font = UIFont.boldSystemFont(ofSize: 34)
        
        iqButton.setupTitle("랜덤 답변하러 가기")
        iqButton.addTarget(self, action: #selector(pressIQButton), for: .touchUpInside)
        
        swiftSceneContainerView.makeCorenerRadius(26)
        swiftSceneContainerView.layer.masksToBounds = true
    }
    
    override func bind() {
        super.bind()
        
        viewModel.answerNumber
            .sink { [weak self] in
                self?.questionCountLabel.text = "\($0)"
//                for _ in 0..<$0 {
//                    self?.swiftScene.addImageNode()
//                }
            }
            .store(in: &cancelBag)
        
//        viewModel.homeState
//            .sink { [weak self] in
//                self?.changeHomeState($0 == .answered)
//            }
//            .store(in: &cancelBag)
    }
    
    
    @IBAction func pressListBarButton(_ sender: Any) {
        let viewControllerName = String(describing: ListViewController.self)
        let storyboard = UIStoryboard(name: viewControllerName, bundle: nil)
        guard let listViewController = storyboard.instantiateViewController(withIdentifier: viewControllerName) as? ListViewController else {
            fatalError()
        }
        listViewController.viewModel = ListViewModel(QuestionStatisticUseCase(QuestionRepository()), QuestionListUseCase(QuestionRepository(), AnswerRepository()), AnswerNumberUseCase(QuestionRepository()))
        self.navigationController?.pushViewController(listViewController, animated: true)
    }
    
    @IBAction func pressSettingBarButton(_ sender: Any) {
        let viewControllerName = String(describing: SettingViewController.self)
        let storyboard = UIStoryboard(name: viewControllerName, bundle: nil)
        guard let settingViewController = storyboard.instantiateViewController(withIdentifier: viewControllerName) as? SettingViewController else {
            fatalError()
        }
        settingViewController.viewModel = SettingViewModel()
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
    private lazy var swiftSceneContainerView: UIView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()
    private lazy var lineView1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var lineView2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var lineView3: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var skView: SKView!
    private var swiftScene: SwiftScene!
}


// MARK: SwiftScene
// TODO: 여긴 대공사가 필요할듯
extension HomeViewController {
    private func setupSwiftScene() {
        skView = SKView(frame: swiftSceneContainerView.bounds)
        swiftScene = SwiftScene(size: skView.bounds.size)
        
        swiftScene.backgroundColor = .clear
        swiftSceneContainerView.backgroundColor = Pallete.point.color
        
        skView.presentScene(swiftScene)
        swiftSceneContainerView.addSubview(skView)
    }
    
    private func calculateSwiftSceneFrame() -> CGRect {
        let width: CGFloat = DeviceInfo.width - 58
        let height: CGFloat = width * 350 / 332
        let minX: CGFloat = 29
        let minY: CGFloat =  guideLabel.frame.maxY - 5
        return CGRect(x: minX, y: minY, width: width, height: height)
    }
    
    private func changeHomeState(_ direction: Bool) {
        let guideText: String = direction ? "매일 답변하는 너란 자식..\n꾸준함 +1" : "답변에는 정답은 없습니다!\n\n매일 인터뷰 질문에 답변을 하며\n자신을 성장시키세요!"
        let buttonText: String = direction ? "한번 더 랜덤 답변하러 가기" : "랜덤 답변하러 가기"
        let isHidden: Bool = direction ? true : false
        guideLabel.text = guideText
        guideLabel.setupLineSpacing(4, alignment: .center)
        iqButton.setupTitle(buttonText)
        questionContainerView.isHidden = isHidden
        questionGuideLabel.isHidden = isHidden
        questionView.isHidden = isHidden
        
        swiftSceneContainerView.isHidden = !isHidden
    }
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
        writingViewController.viewModel = WritingViewModel(nil, RandomQuestionUseCase(QuestionRepository()), WriteAnswerUseCase(AnswerRepository(), QuestionRepository(), TodayAnswerRepository()))
        writingViewController.modalPresentationStyle = .fullScreen
        self.present(writingViewController, animated: true)
    }
}
