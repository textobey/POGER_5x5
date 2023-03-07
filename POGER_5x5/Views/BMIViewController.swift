//
//  BMIViewController.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/02/06.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class BMIViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    let scrollView = UIScrollView().then {
        $0.isScrollEnabled = false
        $0.backgroundColor = .clear
        $0.alwaysBounceVertical = true
    }
    
    let scrollViewContainer = UIView().then {
        $0.backgroundColor = .clear
    }
    
    let bmiDescriptionLabel = UILabel().then {
        $0.text = "개인 정보를 입력할 경우 적절한 트레이닝 중량을 설정해드려요.\n개인 정보는 이 외 다른 목적으로는 이용되지 않아요."
        $0.textColor = .label
        $0.font = .preferredFont(forTextStyle: .body)
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
    
    let tableView = DynamicHeightTableView().then {
        $0.isScrollEnabled = false
        $0.estimatedRowHeight = 44
        $0.rowHeight = UITableView.automaticDimension
        $0.backgroundColor = .secondarySystemBackground
        $0.layer.cornerRadius = 12
        $0.register(InputListCell.self, forCellReuseIdentifier: InputListCell.identifier)
    }
    
    let completeButton = UIButton.commonButton(title: "완료")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "개인 정보 입력"
        view.backgroundColor = .systemBackground
        setupLayout()
        bind()
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
        
        scrollViewContainer.addSubview(bmiDescriptionLabel)
        bmiDescriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        scrollViewContainer.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(bmiDescriptionLabel.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.greaterThanOrEqualTo(tableView.contentSize.height)
        }
        
        view.addSubview(completeButton)
        completeButton.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-52)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(52)
        }
    }
    
    private func bind() {
        Observable.just(Personal.allCases)
            .bind(to: tableView.rx.items(
                cellIdentifier: InputListCell.identifier,
                cellType: InputListCell.self)
            ) { row, element, cell in
                cell.model = element
                
                cell.pickerButton.rx.tap
                    .bind(to: cell.pickerButton.didTapButtonStream)
                    .disposed(by: cell.disposeBag)
            }.disposed(by: disposeBag)
        
        completeButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                let expectedLevelViewController = ExpectedLevelViewController()
                owner.navigationController?.pushViewController(expectedLevelViewController, animated: true)
            }).disposed(by: disposeBag)
    }
}
