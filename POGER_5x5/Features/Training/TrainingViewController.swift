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

//TODO: UI 구상하기 When isSelected
//TODO: 불필요 코드, 파일 정리하기
//TODO: UICollectionViewCompositionalLayout section 구성, 메서드 분리하기
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
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TrainingBoxHeaderView.identifier, for: indexPath) as! TrainingBoxHeaderView
                return header
            }
            return UICollectionReusableView()
        }
    )
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: fetchCollectionViewLayout()).then {
        $0.backgroundColor = .clear
        //$0.isScrollEnabled = true
        //$0.isPagingEnabled = false
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        //$0.contentInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
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
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
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
        let layout = UICollectionViewCompositionalLayout { [weak self]
            sectionIndex,
            layoutEnvironment
            -> NSCollectionLayoutSection? in
            guard let `self` = self else { return .none }
            switch self.dataSource[sectionIndex] {
            case .week:
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
                
                return section
                
            case .training:
                let layoutSize = NSCollectionLayoutSize(
                    widthDimension: .estimated(150),
                    heightDimension: .estimated(100)
                )

                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(
                        widthDimension: layoutSize.widthDimension,
                        heightDimension: layoutSize.heightDimension
                    ),
                    subitems: [.init(layoutSize: layoutSize)]
                )
                //group.interItemSpacing = .fixed(8)
                
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
                //section.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
                section.interGroupSpacing = 8
                
                section.boundarySupplementaryItems = [
                    NSCollectionLayoutBoundarySupplementaryItem(
                        layoutSize: .init(
                            widthDimension: .fractionalWidth(1.0),
                            heightDimension: .absolute(100)
                        ),
                        elementKind: UICollectionView.elementKindSectionHeader,
                        alignment: .top
                    )
                    //NSCollectionLayoutBoundarySupplementaryItem(
                    //    layoutSize: .init(
                    //        widthDimension: .fractionalWidth(1.0),
                    //        heightDimension: .absolute(100)
                    //    ),
                    //    elementKind: UICollectionView.elementKindSectionHeader,
                    //    alignment: .bottom
                    //)
                ]

                return section
            }
        }
        
        return layout
    }
}

class TrainingBoxHeaderView: UICollectionReusableView {
    
    static let identifier = String(describing: TrainingBoxHeaderView.self)
    
    let wrapperView = UIView().then {
        $0.backgroundColor = .systemBackground
    }
    
    let dayLabel = UILabel().then {
        $0.text = "DAY 1"
        $0.textColor = .label
        $0.font = .preferredFont(forTextStyle: .title3)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(wrapperView)
        wrapperView.snp.makeConstraints {
            $0.directionalEdges.equalToSuperview()
        }
        
        addSubview(dayLabel)
        dayLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().offset(-24)
        }
    }
}
