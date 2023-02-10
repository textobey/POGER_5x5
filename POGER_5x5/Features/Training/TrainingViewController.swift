//
//  TrainingViewController.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/02/03.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class TrainingViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    /// run once
    private lazy var takeOncePush: Void = {
        let startViewController = StartViewController()
        let navigationController = UINavigationController(rootViewController: startViewController)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true)
    }()
    
    let tableView = DynamicHeightTableView().then {
        $0.estimatedRowHeight = 44
        $0.rowHeight = UITableView.automaticDimension
        $0.backgroundColor = .clear
        $0.register(TrainingListCell.self, forCellReuseIdentifier: TrainingListCell.identifier)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //MARK: - Start Guide Flow 잠시 비활성화
        //_ = takeOncePush
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.directionalEdges.equalToSuperview()
        }
    }
    
    private func bind() {
        Observable.just(["DAY 1", "DAY 2", "DAY 3"])
            .bind(to: tableView.rx.items(
                cellIdentifier: TrainingListCell.identifier,
                cellType: TrainingListCell.self)
            ) { row, element, cell in
                cell.configureCell(day: element)
            }.disposed(by: disposeBag)
    }
}
