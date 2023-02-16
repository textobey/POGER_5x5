//
//  TrainingListCell.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/02/10.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class TrainingListCell: UITableViewCell {
    
    var disposeBag = DisposeBag()
    
    let dayLabel = UILabel().then {
        $0.text = "DAY 1"
        $0.textColor = .label
        $0.font = .preferredFont(forTextStyle: .title3)
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout).then {
        $0.backgroundColor = .clear
        $0.isScrollEnabled = true
        $0.isPagingEnabled = false
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.contentInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)  
        $0.register(TrainingBoxCell.self, forCellWithReuseIdentifier: TrainingBoxCell.identifier)
    }
    
    private let collectionViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 8
        $0.minimumInteritemSpacing = 0
        $0.estimatedItemSize = CGSize(width: 80, height: 80)
        $0.itemSize = UICollectionViewFlowLayout.automaticSize
    }

    
    // MARK: - initialze method
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        bind()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }

    private func setupLayout() {
        contentView.addSubview(dayLabel)
        dayLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(dayLabel.snp.bottom).offset(18)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-22)
            $0.height.equalTo(100)
        }
    }
    
    func configureCell(day: String) {
        dayLabel.text = day
    }
    
    private func bind() {
        Observable.just([
            ["스쿼트": "40KG"],
            ["스쿼트": "45KG"],
            ["스쿼트": "55KG"],
            ["스쿼트": "65KG"],
            ["스쿼트": "75KG"],
            ["스쿼트": "55KG"]
        ])
        .bind(to: collectionView.rx.items(
            cellIdentifier: TrainingBoxCell.identifier,
            cellType: TrainingBoxCell.self)
        ) { row, element, cell in
            cell.trainingName.text = element.keys.first
            cell.weightLabel.text = element.values.first
        }.disposed(by: disposeBag)
    }
}
