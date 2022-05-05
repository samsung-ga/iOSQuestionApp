//
//  AnswerViewController.swift
//  iOSQuestionApp
//
//  Created by Woody on 2022/05/05.
//

import UIKit

class AnswerViewController: BaseViewController {
    
    var viewModel: AnswerViewModel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear.send(Void())
    }
    
    override func setupAttribute() {
        super.setupAttribute()
        self.navigationItem.title = "질문"
        
        questionLabel.text = viewModel.question.content
        
        collectionView.backgroundColor = Pallete.main.color
        collectionView.registerWithNib(AnswerCollectionViewCell.self)
        
        iqButton.setupTitle("한번 더 답변하러 가기")
        iqButton.addTarget(self, action: #selector(pressIQButton), for: .touchUpInside)
    }
    
    override func bind() {
        viewModel.collectionViewReload
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &cancelBag)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 520)
        ])
        
        view.addSubview(iqButton)
        NSLayoutConstraint.activate([
//            iqButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 33),
            iqButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -25),
            iqButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            iqButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 29),
        ])
    }
    
    @objc private func pressIQButton() {
        let viewControllerName = String(describing: WritingViewController.self)
        let storyboard = UIStoryboard(name: viewControllerName, bundle: nil)
        guard let writingViewController = storyboard.instantiateViewController(withIdentifier: viewControllerName) as? WritingViewController else {
            fatalError()
        }
        print(viewModel.question)
        writingViewController.viewModel = WritingViewModel(viewModel.question, RandomQuestionUseCase(QuestionRepository()), WriteAnswerUseCase(AnswerRepository(), QuestionRepository()))
        writingViewController.modalPresentationStyle = .fullScreen
        self.present(writingViewController, animated: true)
    }
    
    @IBOutlet weak var questionLabel: UILabel!
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let itemWidth: CGFloat = Constant.answerCellWidth
        let itemHeight: CGFloat = 500
        layout.minimumLineSpacing = Constant.minItemSpacing
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let inset: CGFloat = (DeviceInfo.width - Constant.answerCellWidth) / 2
        collectionView.contentInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        collectionView.decelerationRate = .fast
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var iqButton: IQButton = {
        let button = IQButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
}

// MARK: UICollectionViewDataSource
extension AnswerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(AnswerCollectionViewCell.self, for: indexPath) else {
            fatalError()
        }
        let model = viewModel.getAnswerCellViewModel(to: indexPath)
        cell.configure(with: model)
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension AnswerViewController: UICollectionViewDelegate {
    
    // Paging Effect
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let inset: CGFloat = (DeviceInfo.width - Constant.answerCellWidth)
        let width: CGFloat = DeviceInfo.width - inset
        
        let cellWidthIncludingSpacing = width + Constant.minItemSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        var roundedIndex = round(index)
        
        if scrollView.contentOffset.x > targetContentOffset.pointee.x {
            roundedIndex = floor(index)
        } else {
            roundedIndex = ceil(index)
        }
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
}
