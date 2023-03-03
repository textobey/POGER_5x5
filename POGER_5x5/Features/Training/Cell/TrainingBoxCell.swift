////
////  TrainingBoxCell.swift
////  POGER_5x5
////
////  Created by 이서준 on 2023/02/10.
////
//
//import UIKit
//import RxCocoa
//import RxSwift
//import SnapKit
//
//class TrainingBoxCell: UICollectionViewCell {
//
//    static let identifier = String(describing: TrainingBoxCell.self)
//
//    var disposeBag = DisposeBag()
//
//    let dayLabel = UILabel().then {
//        $0.text = "DAY 1"
//        $0.textColor = .label
//        $0.font = .preferredFont(forTextStyle: .title3)
//    }
//
//    var boxView = UIView().then {
//        $0.backgroundColor = .tertiarySystemBackground
//        $0.layer.cornerRadius = 12
//    }
//
//    var trainingName = UILabel().then {
//        $0.text = "데드리프트"
//        $0.textColor = .label
//        $0.numberOfLines = 0
//        $0.textAlignment = .center
//        $0.font = .preferredFont(forTextStyle: .body)
//    }
//
//    var weightLabel = UILabel().then {
//        $0.text = "50KG"
//        $0.textColor = .label
//        $0.numberOfLines = 0
//        $0.textAlignment = .center
//        $0.font = .preferredFont(forTextStyle: .body)
//    }
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupLayout()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func setupLayout() {
//        //contentView.addSubview(dayLabel)
//        //dayLabel.snp.makeConstraints {
//        //    $0.top.equalToSuperview()
//        //    $0.leading.trailing.equalToSuperview().inset(24)
//        //}
//
//        contentView.addSubview(boxView)
//        boxView.snp.makeConstraints {
//            $0.directionalEdges.equalToSuperview()
//            //$0.top.equalTo(dayLabel.snp.bottom).offset(18)
//            //$0.leading.trailing.bottom.equalToSuperview()
//        }
//
//        boxView.addSubview(trainingName)
//        trainingName.snp.makeConstraints {
//            $0.top.equalToSuperview().offset(18)
//            $0.leading.trailing.equalToSuperview().inset(24)
//        }
//
//        boxView.addSubview(weightLabel)
//        weightLabel.snp.makeConstraints {
//            $0.top.equalTo(trainingName.snp.bottom)
//            $0.leading.trailing.equalToSuperview().inset(24)
//            $0.bottom.equalToSuperview().offset(-18)
//        }
//    }
//
//    func configureCell(_ training: Training2) {
//        //dayLabel.text = training.number
//        trainingName.text = training.name
//        weightLabel.text = training.weight + "KG"
//    }
//}
