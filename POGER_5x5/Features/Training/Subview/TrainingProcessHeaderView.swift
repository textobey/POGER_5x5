//
//  TrainingProcessHeaderView.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/03/03.
//

import UIKit
import SnapKit
import RxSwift

class TrainingProcessHeaderView: UICollectionReusableView {
    
    static let identifier = String(describing: TrainingProcessHeaderView.self)
    
    var disposeBag = DisposeBag()
    
    let wrapperView = UIView().then {
        $0.backgroundColor = .systemBackground
    }
    
    let dayLabel = UILabel().then {
        $0.text = "DAY 1"
        $0.textColor = .label
        $0.font = .systemFont(ofSize: 22, weight: .bold)
    }
    
    //TODO: 버튼 타이틀을 무엇으로 할지 결정이 필요함(시작하기? 더보기? 상세?)
    //TODO: 버튼 이미지 추가를 할지 결정이 필요함
    let startButton = UIButton().then {
        $0.setTitle("시작하기", for: .normal)
        //$0.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        //$0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        $0.tintColor = .systemBlue
        $0.titleLabel?.font = .preferredFont(forTextStyle: .body)
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.setTitleColor(.systemBlue.withAlphaComponent(0.6), for: .highlighted)
        $0.semanticContentAttribute = .forceRightToLeft
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
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
        
        addSubview(startButton)
        startButton.snp.makeConstraints {
            $0.centerY.equalTo(dayLabel)
            $0.trailing.equalToSuperview()
        }
    }
}
