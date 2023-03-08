//
//  TrainingDetailViewController.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/03/06.
//

import UIKit
import RxCocoa
import RxDataSources
import RxSwift
import SnapKit

class TrainingDetailViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    let section: TrainingViewSection
    
    //TODO: UserDefaults에 저장된 데이터값으로 초기값 설정하도록 수정
    private var selectedWeekRelay = BehaviorRelay<EveryWeek>(value: .week1)
    
    let dataSource = RxCollectionViewSectionedReloadDataSource<TrainingViewSection>(
        configureCell: { dataSource, collectionView, indexPath, sectionItem in
            switch sectionItem {
            case .training(let training):
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: TrainingContentCell.identifier,
                    for: indexPath
                ) as! TrainingContentCell
                cell.configureCell(training)
                return cell
            }
        },
        configureSupplementaryView: { dataSource, collectionView, kind, indexPath in
            if kind == UICollectionView.elementKindSectionHeader {
                let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: TrainingProcessHeaderView.identifier,
                    for: indexPath
                ) as! TrainingProcessHeaderView
                switch dataSource[indexPath.section] {
                case .training(let title, _):
                    header.startButton.setTitle(title, for: .normal)
                    header.startButton.setImage(nil, for: .normal)
                    header.startButton.isUserInteractionEnabled = false
                }
                return header
            }
            return UICollectionReusableView()
        }
    )
    
    lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: fetchCollectionViewLayout()
    ).then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.register(TrainingContentCell.self, forCellWithReuseIdentifier: TrainingContentCell.identifier)
        $0.register(
            TrainingProcessHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TrainingProcessHeaderView.identifier
        )
        $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
    }
    
    init(section: TrainingViewSection) {
        self.section = section
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupLayout()
        bind()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        if case let .training(day, _) = section {
            self.title = day
        } else {
            self.title = "프로그램"
        }
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
        print(section)
        
        Observable.just([section])
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        selectedWeekRelay
            .map { [weak self] week -> UIBarButtonItem in
                let menu = UIMenu(title: "", options: [], children: self?.generateMenuItems(selected: week) ?? [])
                return UIBarButtonItem(title: "모든 운동", image: nil, menu: menu)
            }
            .bind(to: navigationItem.rx.rightBarButtonItem)
            .disposed(by: disposeBag)
    }
    
    private func fetchCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
            guard let `self` = self else { return .none }
            if case .training = self.dataSource[sectionIndex] {
                return self.generateSectionLayout()
            }
            return .none
        }
        return layout
    }
    
    private func generateSectionLayout() -> NSCollectionLayoutSection {
        let layoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(100)
        )

        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(
                widthDimension: layoutSize.widthDimension,
                heightDimension: layoutSize.heightDimension
            ),
            subitems: [.init(layoutSize: layoutSize)]
        )
        
        // section spacing
        //group.interItemSpacing = .fixed(0)

        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = .init(top: 0, leading: 20, bottom: 10, trailing: 20)
        // cell spacing
        section.interGroupSpacing = 10
        
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
    
    private func generateMenuItems(selected: EveryWeek) -> [UIAction] {
        return EveryWeek.allCases
            .map { week -> UIAction in
                UIAction(
                    title: week.rawValue,
                    image: nil,
                    state: selected == week ? .on : .off,
                    handler: { [weak self] _ in
                        self?.selectedWeekRelay.accept(week)
                    }
                )
            }
    }
}
