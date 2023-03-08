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

//TODO: 운동 리스트 GUI 조정하기
//TODO: 선택된 DAY에 대한 Hightlight 효과 추가
class TrainingViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    lazy var dataSource = RxCollectionViewSectionedReloadDataSource<TrainingViewSection>(
        configureCell: { dataSource, collectionView, indexPath, sectionItem in
            switch sectionItem {
            case .training(let training):
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: TrainingProcessCell.identifier,
                    for: indexPath
                ) as! TrainingProcessCell
                cell.configureCell(training)
                if collectionView.isFirstCell(indexPath) {
                    cell.appendCornerRadius(at: .top)
                } else if collectionView.isLastCell(indexPath) {
                    cell.appendCornerRadius(at: .bottom)
                }
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
                    header.startButton.rx.tap
                        .map { dataSource[indexPath.section] }
                        .subscribe(onNext: { [weak self] section in
                            self?.navigateToDetailViewController(section)
                        })
                        .disposed(by: header.disposeBag)
                }
                return header
            }
            return UICollectionReusableView()
        }
    )
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: fetchCollectionViewLayout()).then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.register(TrainingProcessCell.self, forCellWithReuseIdentifier: TrainingProcessCell.identifier)
        $0.register(
            TrainingProcessHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TrainingProcessHeaderView.identifier
        )
        $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        presentStartViewController()
        setupLayout()
        bind()
    }
    
    private func presentStartViewController() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            let startViewController = StartViewController()
            let navigationController = UINavigationController(rootViewController: startViewController)
            navigationController.navigationBar.prefersLargeTitles = true
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: false)
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
        let sections: [TrainingViewSection] = [
            .training(title: "DAY 1", items: R.Process.day1DataSource.map { TrainingViewSectionItem.training($0) }),
            .training(title: "DAY 2", items: R.Process.day2DataSource.map { TrainingViewSectionItem.training($0) }),
            .training(title: "DAY 3", items: R.Process.day3DataSource.map { TrainingViewSectionItem.training($0) })
        ]

        Observable.just(sections)
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        collectionView.rx.itemSelected
            .withUnretained(self)
            .map { $0.0.dataSource[$0.1.section] }
            .subscribe(onNext: { [weak self] section in
                self?.navigateToDetailViewController(section)
            })
            .disposed(by: disposeBag)
    }
    
    private func fetchCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
            guard let `self` = self else { return .none }
            if case .training = self.dataSource[sectionIndex] {
                return self.generateTrainingSectionLayout()
            }
            return .none
        }
        return layout
    }
    
    private func generateTrainingSectionLayout() -> NSCollectionLayoutSection {
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

        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = .init(top: 0, leading: 20, bottom: 20, trailing: 20)
        // cell spacing
        section.interGroupSpacing = 0
        
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
    
    private func navigateToDetailViewController(_ section: TrainingViewSection) {
        let viewController = TrainingDetailViewController(section: section)
        //TODO: hidesBottomBarWhenPushed 프로퍼티를 true? false?
        //viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
    }
}
