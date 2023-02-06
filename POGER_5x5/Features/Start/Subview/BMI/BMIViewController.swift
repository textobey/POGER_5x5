//
//  BMIViewController.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/02/06.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class BMIViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    let scrollView = UIScrollView().then {
        $0.isScrollEnabled = false
        $0.backgroundColor = .clear
        $0.alwaysBounceVertical = true
    }
    
    let scrollViewContainer = UIView().then {
        $0.backgroundColor = .clear
    }
    
    let bmiDescriptionLabel = UILabel().then {
        $0.text = "개인 정보 입력은 필수로 요구되지 않아요.\n개인 정보를 입력할 경우 개인별 프로그램 레벨을 확인할 수 있어요."
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
    
    let completeButton = UIButton.commonButton(title: "완료")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "개인 정보 입력"
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
        
        scrollViewContainer.addSubview(bmiDescriptionLabel)
        bmiDescriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(28)
            $0.leading.trailing.equalToSuperview().offset(16)
        }
        
        scrollViewContainer.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(bmiDescriptionLabel.snp.bottom).offset(36)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.greaterThanOrEqualTo(tableView.contentSize.height)
        }
        
        view.addSubview(completeButton)
        completeButton.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-28)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(56)
        }
    }
    
    private func bind() {
        Observable.just(["성별", "신장", "체중"])
            .bind(to: tableView.rx.items(
                cellIdentifier: LevelCheckListCell.identifier,
                cellType: LevelCheckListCell.self)
            ) { row, element, cell in
                cell.configureCell(type: element)
            }.disposed(by: disposeBag)
        
        completeButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                let expectedLevelViewController = ExpectedLevelViewController()
                owner.navigationController?.pushViewController(expectedLevelViewController, animated: true)
            }).disposed(by: disposeBag)
    }
}
