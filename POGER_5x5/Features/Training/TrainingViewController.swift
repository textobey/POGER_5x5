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
    
    //TODO: 마지막 Cell 위치까지 스크롤 되지 않는 이슈 해결
    //TODO: WeekCircleCell도 TrainingListCell에 포함시키기
    //TODO: UI 구상하기 When isSelected
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout).then {
        $0.backgroundColor = .clear
        $0.isScrollEnabled = true
        $0.isPagingEnabled = false
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.contentInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
        $0.register(WeekCircleCell.self, forCellWithReuseIdentifier: WeekCircleCell.identifier)
    }
    
    private let collectionViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 16
        $0.minimumInteritemSpacing = 0
        $0.estimatedItemSize = CGSize(width: 80, height: 80)
        $0.itemSize = UICollectionViewFlowLayout.automaticSize
    }
    
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
        //TODO: 초기 실행시, TrainingViewController 잠시 표시된 이후에 present 되는 문제 해결
        _ = takeOncePush
    }
    
    private func setupLayout() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(80)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
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
        
        Observable.just(
            Array(repeating: "WEEK ", count: 12)
                .enumerated()
                .map { index, element in
                    element + "\(index + 1)"
                }
        ).bind(to: collectionView.rx.items(
            cellIdentifier: WeekCircleCell.identifier,
            cellType: WeekCircleCell.self
        )) { row, element, cell in
            cell.weekLabel.text = element
        }.disposed(by: disposeBag)
    }
}
