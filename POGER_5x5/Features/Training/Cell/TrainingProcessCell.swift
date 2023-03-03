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
        //$0.layer.cornerRadius = 12
    }
    
    let repLabel = UILabel().then {
        $0.text = "5x"
        $0.textColor = .label
        $0.textAlignment = .center
        $0.numberOfLines = 1
        $0.font = .preferredFont(forTextStyle: .title3)
    }
    
    let trainingNameLabel = UILabel().then {
        $0.textColor = .label
        $0.textAlignment = .center
        $0.numberOfLines = 1
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
        contentView.addSubview(wrapperView)
        wrapperView.snp.makeConstraints {
            $0.directionalEdges.equalToSuperview()
        }
        
        contentView.addSubview(repLabel)
        repLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().offset(16)
        }
        
        contentView.addSubview(trainingNameLabel)
        trainingNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(repLabel)
            $0.leading.equalTo(repLabel.snp.trailing).offset(10)
        }
    }
    
    func configureCell(_ model: DayTraining) {
        repLabel.text = model.rep
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
