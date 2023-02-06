//
//  ExpectedLevelViewController.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/02/06.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class ExpectedLevelViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    let scrollView = UIScrollView().then {
        $0.isScrollEnabled = false
        $0.backgroundColor = .clear
        $0.alwaysBounceVertical = true
    }
    
    let scrollViewContainer = UIView().then {
        $0.backgroundColor = .clear
    }
    
    let expectedLevelDescriptionLabel = UILabel().then {
        $0.text = "입력된 값을 바탕으로 구성된 예상 기록을 확인해보세요!"
        $0.textColor = .secondaryLabel
        $0.font = .notoSans(size: 18, style: .medium)
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
    
    let stackView = UIStackView().then {
        $0.distribution = .equalSpacing
        $0.alignment = .fill
        $0.axis = .vertical
        $0.spacing = 4
    }
    
    let confirmButton = UIButton.commonButton(title: "완료")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "설정 완료"
        view.backgroundColor = .systemBackground
        setupLayout()
        bindDataSources()
        bindRx()
    }
    
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        scrollView.addSubview(scrollViewContainer)
        scrollViewContainer.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.size.width)
        }
        
        scrollViewContainer.addSubview(expectedLevelDescriptionLabel)
        expectedLevelDescriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(28)
            $0.leading.trailing.equalToSuperview().offset(16)
        }
        
        scrollViewContainer.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalTo(expectedLevelDescriptionLabel.snp.bottom).offset(36)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        view.addSubview(confirmButton)
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-28)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(56)
        }
    }
    
    private func bindDataSources() {
        let dataSoruces = [
            ["레벨": "초급자"],
            ["예상 1회 기록": "50"],
            ["예상 3회 기록": "50"],
            ["예상 5회 기록": "50"],
            ["예상 3대 기록": "150"]
        ]
        
        for (_, dataSource) in dataSoruces.enumerated() {
            let view = ExpectedLevelInformationView(expectedLevel: dataSource)
            stackView.addArrangedSubview(view)
        }
    }
    
    private func bindRx() {
        confirmButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.dismiss(animated: true)
            }).disposed(by: disposeBag)
    }
}

fileprivate class ExpectedLevelInformationView: UIView {
    
    private let expectedLevelDictionary: [String: String]
    
    let wrapperView = UIView().then {
        $0.backgroundColor = .secondarySystemBackground
        $0.layer.cornerRadius = 12
    }
    
    let informationIcon = UIImageView().then {
        $0.image = UIImage(systemName: "figure.run")
        $0.tintColor = .white
    }
    
    let informationTitle = UILabel().then {
        $0.textColor = .secondaryLabel
        $0.font = .notoSans(size: 14, style: .medium)
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
    
    let expectedLevel = UILabel().then {
        $0.textColor = .systemGreen
        $0.font = .notoSans(size: 18, style: .medium)
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
    
    init(expectedLevel: [String: String]) {
        self.expectedLevelDictionary = expectedLevel
        super.init(frame: .zero)
        setupLayout()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(wrapperView)
        wrapperView.snp.makeConstraints {
            $0.directionalEdges.equalToSuperview()
        }
        
        wrapperView.addSubview(informationIcon)
        informationIcon.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(22)
        }
        
        wrapperView.addSubview(informationTitle)
        informationTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalTo(informationIcon.snp.trailing).offset(14)
        }
        
        wrapperView.addSubview(expectedLevel)
        expectedLevel.snp.makeConstraints {
            $0.top.equalTo(informationTitle.snp.bottom)
            $0.leading.equalTo(informationTitle)
            $0.bottom.equalToSuperview().offset(-12)
        }
    }
    
    private func bind() {
        informationTitle.text = expectedLevelDictionary.keys.first
        expectedLevel.text = expectedLevelDictionary.values.first
    }
}
