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
    
    let dataSource = RxCollectionViewSectionedReloadDataSource<TrainingViewSection>(
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
                case .training(let day, _):
                    header.dayLabel.text = day
                }
                return header
            }
            return UICollectionReusableView()
        }
    )
    
    //TODO: 이미지를 제작하여 표시할것인지, Label Text Button으로 표시할것인지 GUI 결정
    private let allWeekButton = UIButton().then {
        $0.setTitle("변경", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.setTitleColor(.systemGray, for: .highlighted)
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: fetchCollectionViewLayout()).then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.register(TrainingProcessCell.self, forCellWithReuseIdentifier: TrainingProcessCell.identifier)
        $0.register(
            TrainingProcessHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TrainingProcessHeaderView.identifier
        )
        $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 48, right: 0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presentStartViewController()
        setupNavigationBarItem()
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
    
    private func setupNavigationBarItem() {
        let barButtonItem = UIBarButtonItem(customView: allWeekButton)
        navigationItem.setRightBarButtonItems([barButtonItem], animated: false)
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
            .training(day: "DAY 1", items: R.Process.day1DataSource.map { TrainingViewSectionItem.training($0) }),
            .training(day: "DAY 2", items: R.Process.day2DataSource.map { TrainingViewSectionItem.training($0) }),
            .training(day: "DAY 3", items: R.Process.day3DataSource.map { TrainingViewSectionItem.training($0) })
        ]

        Observable.just(sections)
            .bind(to: collectionView.rx.items(dataSource: dataSource))
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
            widthDimension: .absolute(UIScreen.main.bounds.size.width - 48),
            heightDimension: .estimated(50)
        )

        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(
                widthDimension: layoutSize.widthDimension,
                heightDimension: layoutSize.heightDimension
            ),
            subitems: [.init(layoutSize: layoutSize)]
        )

        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = .init(top: 0, leading: 24, bottom: 0, trailing: 24)
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
}
