//
//  TrainingBoxHeaderView.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/02/17.
//

import UIKit
import SnapKit

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
            $0.top.equalToSuperview().offset(24)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-24)
        }
    }
}
