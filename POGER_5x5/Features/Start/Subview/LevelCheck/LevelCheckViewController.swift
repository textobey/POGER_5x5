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
        self.title = "스트렝스 레벨 입력"
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
            $0.top.equalToSuperview().offset(28)
            $0.leading.trailing.equalToSuperview().offset(16)
        }
        
        scrollViewContainer.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(levelCheckDescriptionLabel.snp.bottom).offset(36)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.greaterThanOrEqualTo(tableView.contentSize.height)
            //$0.bottom.equalToSuperview()
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
        Observable.just(["스쿼트", "벤치프레스", "데드리프트", "펜들레이로우", "오버헤드프레스"])
            .bind(to: tableView.rx.items(
                cellIdentifier: LevelCheckListCell.identifier,
                cellType: LevelCheckListCell.self)
            ) { row, element, cell in
                cell.configureCell(type: element)
//                cell.bookmarkTap
//                    .map { NewBookReactor.Action.bookmark($0, bookItem) }
//                    .bind(to: reactor.action)
//                    .disposed(by: cell.disposeBag)
            }.disposed(by: disposeBag)
        
        nextButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                let trainingEnvironmentViewController = TrainingEnvironmentViewController()
                owner.navigationController?.pushViewController(trainingEnvironmentViewController, animated: true)
            }).disposed(by: disposeBag)
    }
}
