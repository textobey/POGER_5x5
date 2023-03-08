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
    
    let startButton = UIButton().then {
        $0.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        $0.setTitleColor(.label, for: .normal)
        $0.setTitleColor(.label.withAlphaComponent(0.6), for: .highlighted)
        let boldConfiguration = UIImage.SymbolConfiguration(weight: .bold)
        $0.setImage(UIImage(systemName: "chevron.backward", withConfiguration: boldConfiguration), for: .normal)
        $0.tintColor = .systemGray
        //TODO: UIButton.Configuration 객체를 사용하여 label 관련 프로퍼티를 함께 핸들링 할 수 있는법 조사가 필요함
        $0.imageEdgeInsets = UIEdgeInsets(top: 1, left: 0, bottom: 0, right: -8)
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
        
        addSubview(startButton)
        startButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-24)
        }
    }
}
