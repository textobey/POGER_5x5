//
//  WeekCircleCell.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/02/11.
//

//import UIKit
//import RxSwift
//import RxCocoa
//import SnapKit
//
//class WeekCircleCell: UICollectionViewCell {
//
//    static let identifier = String(describing: WeekCircleCell.self)
//
//    var disposeBag = DisposeBag()
//
//    private enum Const {
//        static let circleSize = CGSize(width: 80, height: 80)
//    }
//
//    let circleView = UIView().then {
//        $0.backgroundColor = .tertiarySystemBackground
//        $0.layer.cornerRadius = Const.circleSize.height / 2
//    }
//
//    let weekLabel = UILabel().then {
//        $0.text = "WEEK 1"
//        $0.textColor = .label
//        $0.textAlignment = .center
//        $0.numberOfLines = 1
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
//        contentView.addSubview(circleView)
//        circleView.snp.makeConstraints {
//            $0.directionalEdges.equalToSuperview()
//            $0.size.equalTo(Const.circleSize)
//        }
//
//        circleView.addSubview(weekLabel)
//        weekLabel.snp.makeConstraints {
//            $0.center.equalToSuperview()
//        }
//    }
//
//    func configureCell(_ week: Week) {
//        weekLabel.text = week.number
//    }
//}
