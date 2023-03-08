//
//  TrainingProcessCell.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/03/02.
//

import UIKit
import SnapKit

class TrainingProcessCell: UICollectionViewCell {
    
    static let identifier = String(describing: TrainingProcessCell.self)
    
    let wrapperView = UIView().then {
        $0.backgroundColor = .secondarySystemBackground
    }
    
    let repIcon = UIImageView().then {
        $0.image = R.SFSymbol.goforwardFive
        $0.backgroundColor = .clear
        $0.tintColor = .systemGray
    }
    
    let trainingNameLabel = UILabel().then {
        $0.textColor = .label
        $0.textAlignment = .left
        $0.numberOfLines = 1
        $0.font = .preferredFont(forTextStyle: .body)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.addSubview(wrapperView)
        wrapperView.snp.makeConstraints {
            $0.directionalEdges.equalToSuperview()
        }
        
        wrapperView.addSubview(repIcon)
        repIcon.snp.makeConstraints {
            $0.top.bottom.equalTo(wrapperView).inset(12)
            $0.leading.equalToSuperview().offset(16)
            $0.size.equalTo(24).priority(.high)
        }
        
        wrapperView.addSubview(trainingNameLabel)
        trainingNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(repIcon)
            $0.leading.equalTo(repIcon.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().offset(-10)
        }
    }
    
    func configureCell(_ model: DayTraining) {
        repIcon.image = model.rep
        trainingNameLabel.text = model.training.rawValue
    }
    
    func appendCornerRadius(at direction: Direction) {
        if case .top = direction {
            wrapperView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            wrapperView.layer.cornerRadius = 12
        } else if case .bottom = direction {
            wrapperView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            wrapperView.layer.cornerRadius = 12
        }
    }
}
