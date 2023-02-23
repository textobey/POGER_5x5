//
//  PickerButtonToolbarView.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/02/21.
//

import UIKit
import SnapKit

class PickerButtonToolbarView: UIView {
    
    let outSideViewTapGesture = UITapGestureRecognizer()
    
    lazy var outSideView = UIView().then {
        $0.backgroundColor = .clear
        $0.addGestureRecognizer(outSideViewTapGesture)
    }
    
    let toolbarWrapper = UIView().then {
        $0.backgroundColor = .tertiarySystemBackground
    }
    
    let doneButton = UIButton().then {
        $0.setTitle("완료", for: .normal)
        $0.setTitleColor(UIColor.label, for: .normal)
        $0.titleLabel?.font = .preferredFont(forTextStyle: .callout)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(outSideView)
        outSideView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        addSubview(toolbarWrapper)
        toolbarWrapper.snp.makeConstraints {
            $0.top.equalTo(outSideView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        toolbarWrapper.addSubview(doneButton)
        doneButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-24)
            $0.centerY.equalToSuperview()
        }
    }
}
