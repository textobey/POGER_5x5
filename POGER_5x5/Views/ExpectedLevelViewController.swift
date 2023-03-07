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
        $0.text = "입력된 값을 바탕으로 구성된 예상 스트렝스 레벨과\n기록을 확인해보세요!"
        $0.textColor = .label
        $0.font = .preferredFont(forTextStyle: .body)
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
    
    let tableView = DynamicHeightTableView().then {
        $0.separatorStyle = .none
        $0.isScrollEnabled = false
        $0.estimatedRowHeight = 44
        $0.rowHeight = UITableView.automaticDimension
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = 12
        $0.register(ExpectedLevelCell.self, forCellReuseIdentifier: ExpectedLevelCell.identifier)
    }
    
    let confirmButton = UIButton.commonButton(title: "완료")
    
    lazy var activityIndicator = ActivityIndicator(superview: view)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "설정 완료"
        view.backgroundColor = .systemBackground
        setupLayout()
        activityIndicator.showActivityIndicator(text: "계산 중")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            self.bind()
            self.activityIndicator.stopActivityIndicator()
        }
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
            $0.top.equalToSuperview().offset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        scrollViewContainer.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(expectedLevelDescriptionLabel.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.greaterThanOrEqualTo(tableView.contentSize.height)
        }
        
        view.addSubview(confirmButton)
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-52)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(52)
        }
    }
    
    private func bind() {
        let dataSource = [
            Expectation(type: .level, record: "초급자"),
            Expectation(type: .maximum1Rep, record: "50"),
            Expectation(type: .maximum3Rep, record: "50"),
            Expectation(type: .maximum5Rep, record: "50"),
            Expectation(type: .sbdRecord, record: "150")
        ]
        
        Observable.just(dataSource)
            .bind(to: tableView.rx.items(
                cellIdentifier: ExpectedLevelCell.identifier,
                cellType: ExpectedLevelCell.self)
            ) { row, element, cell in
                cell.alpha = 0
                cell.configureCell(element)
                
                UIView.animate(
                    withDuration: 0.5,
                    delay: 0.5 * Double(row),
                    animations: {
                        cell.alpha = 1
                    }
                )
            }.disposed(by: disposeBag)
        
        
        confirmButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.dismiss(animated: true)
            }).disposed(by: disposeBag)
    }
}
