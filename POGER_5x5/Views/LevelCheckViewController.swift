//
//  LevelCheckViewController.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/02/03.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class LevelCheckViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    let scrollView = UIScrollView().then {
        $0.isScrollEnabled = false
        $0.backgroundColor = .clear
        $0.alwaysBounceVertical = true
    }
    
    let scrollViewContainer = UIView().then {
        $0.backgroundColor = .clear
    }
    
    let levelCheckDescriptionLabel = UILabel().then {
        $0.text = "본인의 최고 1회기록(1RM)의\n80% 무게값으로 설정하시는걸 권장드려요."
        $0.textColor = .label
        $0.font = .preferredFont(forTextStyle: .body)
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
    
    let tableView = DynamicHeightTableView().then {
        $0.isScrollEnabled = false
        $0.estimatedRowHeight = 44
        $0.rowHeight = UITableView.automaticDimension
        $0.backgroundColor = .secondarySystemBackground
        $0.layer.cornerRadius = 12
        $0.register(InputListCell.self, forCellReuseIdentifier: InputListCell.identifier)
    }
    
    let nextButton = UIButton.commonButton(title: "계속")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "웨이트 레벨 입력"
        view.backgroundColor = .systemBackground
        setupLayout()
        bind()
    }
    
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        scrollView.addSubview(scrollViewContainer)
        scrollViewContainer.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.size.width)
        }
        
        scrollViewContainer.addSubview(levelCheckDescriptionLabel)
        levelCheckDescriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        scrollViewContainer.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(levelCheckDescriptionLabel.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.greaterThanOrEqualTo(tableView.contentSize.height)
        }
        
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-52)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(52)
        }
    }
    
    private func bind() {
        Observable.just(Training.weightTop5)
            .bind(to: tableView.rx.items(
                cellIdentifier: InputListCell.identifier,
                cellType: InputListCell.self)
            ) { row, element, cell in
                cell.configureCell(element)
                
                cell.pickerButton.rx.tap
                    .bind(to: cell.pickerButton.didTapButtonStream)
                    .disposed(by: cell.disposeBag)
            }.disposed(by: disposeBag)
        
        nextButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                if owner.fetchCompletedSubmit() {
                    owner.navigateToTrainingEnvironmentViewController()
                } else {
                    owner.showSubmitRequestAlert()
                }
            }).disposed(by: disposeBag)
    }
    
    private func showSubmitRequestAlert() {
        let alert = UIAlertController(
            title: "레벨 입력하기",
            message: "변경되지 않은 무게값이 존재해요. 유지하고 넘어갈까요?",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(
            title: "취소",
            style: .cancel
        ))
        alert.addAction(UIAlertAction(
            title: "확인",
            style: .default,
            handler: { [weak self] _ in
                self?.navigateToTrainingEnvironmentViewController()
            }
        ))
        present(alert, animated: true)
    }
    
    private func fetchCompletedSubmit() -> Bool {
        tableView.cells
            .map { $0 as! InputListCell }
            .map { $0.isSubmit }
            .allSatisfy { $0 }
    }
    
    private func navigateToTrainingEnvironmentViewController() {
        let trainingEnvironmentViewController = TrainingEnvironmentViewController()
        navigationController?.pushViewController(trainingEnvironmentViewController, animated: true)
    }
}
