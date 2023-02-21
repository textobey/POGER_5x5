//
//  WeightSliderView.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/02/21.
//

import UIKit
import SnapKit

class WeightSliderView: UIView {
    
    let wrapperView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    let slider = FlexibleHeightSlider().then {
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = 10.0
        $0.layer.shadowOpacity = 0.5
        $0.layer.masksToBounds = false
        $0.minimumValue = 20
        $0.maximumValue = 250
        $0.value = 0.0
        $0.minimumTrackTintColor = ColorTheme.poGreen
        $0.maximumTrackTintColor = .systemGray
    }
    
    let titleLabel = UILabel().then {
        $0.textColor = .label
        $0.font = .preferredFont(forTextStyle: .title3)
        $0.textAlignment = .left
        $0.numberOfLines = 1
    }
    
    let guessWeightLabel = UILabel().then {
        $0.text = "예상 110KG"
        $0.textColor = .label
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.textAlignment = .left
        $0.numberOfLines = 1
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
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
        
        wrapperView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        wrapperView.addSubview(guessWeightLabel)
        guessWeightLabel.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.leading.equalTo(titleLabel.snp.trailing)
            $0.trailing.equalToSuperview()
        }
        
        wrapperView.addSubview(slider)
        slider.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(56)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-36)
            $0.height.equalTo(42)
        }
    }
}
