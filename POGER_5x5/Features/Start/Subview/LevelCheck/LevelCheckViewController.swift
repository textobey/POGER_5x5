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
    
    let testRelay = PublishRelay<[String]>()
    
    let scrollView = UIScrollView().then {
        $0.alwaysBounceVertical = true
    }
    
    let levelCheckDescriptionLabel = UILabel().then {
        $0.text = "본인의 최고 1회기록(1RM)의\n80% 무게값으로 설정하시는걸 권장드립니다."
        $0.textColor = .secondaryLabel
        $0.font = .notoSans(size: 18, style: .medium)
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
    
    let tableView = UITableView().then {
        $0.isScrollEnabled = false
        $0.estimatedRowHeight = 50
        $0.rowHeight = UITableView.automaticDimension
        $0.backgroundColor = .secondarySystemBackground
        $0.register(LevelCheckListCell.self, forCellReuseIdentifier: LevelCheckListCell.identifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "스트렝스 레벨 입력"
        view.backgroundColor = .systemBackground
        setupLayout()
        bind()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        testRelay.accept(["스쿼트", "벤치프레스", "데드리프트", "펜들레이로우", "오버헤드프레스"])
    }
    
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.width.equalTo(UIScreen.main.bounds.size.width)
            $0.height.equalTo(1000)
        }
        
        scrollView.addSubview(levelCheckDescriptionLabel)
        levelCheckDescriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(28)
            $0.leading.equalToSuperview().offset(16)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.directionalEdges.equalToSuperview()
            //$0.top.equalTo(levelCheckDescriptionLabel.snp.bottom).offset(36)
            //$0.leading.trailing.equalToSuperview().inset(16)
            //$0.bottom.equalToSuperview()
            $0.height.equalTo(500)
        }
    }
    
    private func bind() {
        testRelay
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
    }
}
