//
//  TrainingViewController.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/02/03.
//

import UIKit
import RxCocoa
import RxDataSources
import RxSwift
import SnapKit

//TODO: UI 구상하기 when isSelected
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
    
    let dataSource = RxCollectionViewSectionedReloadDataSource<TrainingViewSection>(
        configureCell: { dataSource, collectionView, indexPath, sectionItem in
            switch sectionItem {
            case .week(let week):
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: WeekCircleCell.identifier,
                    for: indexPath
                ) as! WeekCircleCell
                cell.configureCell(week)
                return cell
            case .training(let training):
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: TrainingBoxCell.identifier,
                    for: indexPath
                ) as! TrainingBoxCell
                cell.configureCell(training)
                return cell
            }
        },
        configureSupplementaryView: { dataSource, collectionView, kind, indexPath in
            if kind == UICollectionView.elementKindSectionHeader {
                let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: TrainingBoxHeaderView.identifier
                    , for: indexPath
                ) as! TrainingBoxHeaderView
                switch dataSource[indexPath.section] {
                case .training(let day, _):
                    header.dayLabel.text = day
                default:
                    break
                }
                return header
            }
            return UICollectionReusableView()
        }
    )
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: fetchCollectionViewLayout()).then {
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.register(WeekCircleCell.self, forCellWithReuseIdentifier: WeekCircleCell.identifier)
        $0.register(TrainingBoxCell.self, forCellWithReuseIdentifier: TrainingBoxCell.identifier)
        $0.register(
            TrainingBoxHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TrainingBoxHeaderView.identifier
        )
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
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func bind() {
        let weekItem = Array(repeating: "WEEK ", count: 12)
            .enumerated()
            .map { index, element in
                element + "\(index + 1)"
            }.map { number in
                return TrainingViewSectionItem.week(Week(number: number))
            }
        
        let trainingItem: [TrainingViewSectionItem] = [
            .training(Training(name: "데드리프트", weight: "50")),
            .training(Training(name: "스쿼트", weight: "50")),
            .training(Training(name: "벤치프레스", weight: "50")),
            .training(Training(name: "펜들레이로우", weight: "50")),
            .training(Training(name: "하이바", weight: "50")),
            .training(Training(name: "오버헤드프레스", weight: "50")),
        ]
        
        let sections: [TrainingViewSection] = [
            .week(items: weekItem),
            .training(day: "DAY 1", items: trainingItem),
            .training(day: "DAY 2", items: trainingItem),
            .training(day: "DAY 3", items: trainingItem),
        ]

        Observable.just(sections)
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    private func fetchCollectionViewLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment -> NSCollectionLayoutSection? in
            guard let `self` = self else { return .none }
            switch self.dataSource[sectionIndex] {
            case .week:
                return self.generateWeekSectionLayout()
                
            case .training:
                return self.generateTrainingSectionLayout()
            }
        }
    }
    
    private func generateWeekSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(80),
            heightDimension: .absolute(80)
        )
        
        let weekItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(80),
            heightDimension: .absolute(80)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: weekItem,
            count: 1
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 16, leading: 24, bottom: 16, trailing: 24)
        section.interGroupSpacing = 8
        
        return section
    }
    
    private func generateTrainingSectionLayout() -> NSCollectionLayoutSection {
        let layoutSize = NSCollectionLayoutSize(
            widthDimension: .estimated(150),
            heightDimension: .estimated(50)
        )

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: layoutSize.widthDimension,
                heightDimension: layoutSize.heightDimension
            ),
            subitems: [.init(layoutSize: layoutSize)]
        )
        
        let containerGroupSize = NSCollectionLayoutSize(
            widthDimension: .estimated(150),
            heightDimension: .estimated(100)
        )
        
        let containerGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: containerGroupSize,
            subitems: [group]
        )

        let section = NSCollectionLayoutSection(group: containerGroup) //group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 24, bottom: 0, trailing: 24)
        section.interGroupSpacing = 8
        
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(50)
                ),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
        ]

        return section
    }
}
