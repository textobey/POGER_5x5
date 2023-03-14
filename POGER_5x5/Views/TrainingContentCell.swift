//
//  TrainingContentCell.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/03/06.
//

import UIKit
import SnapKit

class TrainingContentCell: UICollectionViewCell {
    
    static let identifier = String(describing: TrainingContentCell.self)
    
    let wrapperView = UIView().then {
        $0.layer.cornerRadius = 12
        $0.backgroundColor = .secondarySystemBackground
    }
    
    let turnLabel = UILabel().then {
        $0.text = "1세트"
        $0.textColor = .label
        $0.numberOfLines = 0
        $0.textAlignment = .left
        $0.font = .preferredFont(forTextStyle: .body)
    }
    
    let weightLabel = UILabel().then {
        $0.text = "35KG"
        $0.textColor = .label
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.font = .preferredFont(forTextStyle: .body)
    }
    
    let repLabel = UILabel().then {
        $0.text = "5회"
        $0.textColor = .label
        $0.numberOfLines = 0
        $0.textAlignment = .right
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
        
        wrapperView.addSubview(turnLabel)
        turnLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().offset(16)
        }
        
        wrapperView.addSubview(weightLabel)
        weightLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.centerX.equalToSuperview()
        }
        
        wrapperView.addSubview(repLabel)
        repLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.trailing.equalToSuperview().offset(-16)
        }
    }
    
    func configureCell(_ model: DayTrainingDetail) {
        weightLabel.text = "\(model.weight ?? 0)"
        //repLabel.text = model.rep
    }
}
