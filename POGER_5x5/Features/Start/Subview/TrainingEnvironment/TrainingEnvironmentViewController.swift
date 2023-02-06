//
//  TrainingEnvironmentViewController.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/02/06.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class TrainingEnvironmentViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    let scrollView = UIScrollView().then {
        $0.isScrollEnabled = false
        $0.backgroundColor = .clear
        $0.alwaysBounceVertical = true
    }
    
    let scrollViewContainer = UIView().then {
        $0.backgroundColor = .clear
    }
    
    let trainingEnvironmentDescriptionLabel = UILabel().then {
        $0.text = "진행될 프로그램에 필요한 훈련 환경을 입력해주세요.\n처음 입력된 값은 훈련의 기본 권장값이에요."
        $0.textColor = .secondaryLabel
        $0.font = .notoSans(size: 18, style: .medium)
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
    
    let tableView = DynamicHeightTableView().then {
        $0.isScrollEnabled = false
        $0.estimatedRowHeight = 44
        $0.rowHeight = UITableView.automaticDimension
        $0.backgroundColor = .secondarySystemBackground
        $0.layer.cornerRadius = 12
        $0.register(LevelCheckListCell.self, forCellReuseIdentifier: LevelCheckListCell.identifier)
    }
    
    let nextButton = UIButton.commonButton(title: "계속")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "훈련 환경 입력"
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
        
        scrollViewContainer.addSubview(trainingEnvironmentDescriptionLabel)
        trainingEnvironmentDescriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(28)
            $0.leading.trailing.equalToSuperview().offset(16)
        }
        
        scrollViewContainer.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(trainingEnvironmentDescriptionLabel.snp.bottom).offset(36)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.greaterThanOrEqualTo(tableView.contentSize.height)
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-28)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(56)
        }
    }
    
    private func bind() {
        Observable.just(["횟수", "세트간 무게차이", "가장 작은 원판의 무게", "본인의 기록과 같아지는 훈련의 주"])
            .bind(to: tableView.rx.items(
                cellIdentifier: LevelCheckListCell.identifier,
                cellType: LevelCheckListCell.self)
            ) { row, element, cell in
                cell.configureCell(type: element)
            }.disposed(by: disposeBag)
        
        nextButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                let bmiViewController = BMIViewController()
                owner.navigationController?.pushViewController(bmiViewController, animated: true)
            }).disposed(by: disposeBag)
    }
}
