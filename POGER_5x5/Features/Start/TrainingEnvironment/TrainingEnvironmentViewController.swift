//
//  TrainingEnvironmentViewController.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/02/06.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class TrainingEnvironmentViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    let scrollView = UIScrollView().then {
        $0.isScrollEnabled = false
        $0.backgroundColor = .clear
        $0.alwaysBounceVertical = true
    }
    
    let scrollViewContainer = UIView().then {
        $0.backgroundColor = .clear
    }
    
    let trainingEnvironmentDescriptionLabel = UILabel().then {
        $0.text = "진행될 프로그램에 필요한 훈련 환경을 입력해주세요.\n처음 입력된 값은 권장값으로 바꾸지 않으시는걸 추천드려요."
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
    
    let nextButton = UIButton.commonButton(title: "계속")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "훈련 환경 입력"
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
        
        scrollViewContainer.addSubview(trainingEnvironmentDescriptionLabel)
        trainingEnvironmentDescriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        scrollViewContainer.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(trainingEnvironmentDescriptionLabel.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.greaterThanOrEqualTo(tableView.contentSize.height)
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-52)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(52)
        }
    }
    
    private func bind() {
        Observable.just(Precondition.allCases)
            .bind(to: tableView.rx.items(
                cellIdentifier: InputListCell.identifier,
                cellType: InputListCell.self)
            ) { row, element, cell in
                cell.model = element
                
                cell.pickerButton.rx.tap
                    .withUnretained(self)
                    .subscribe(onNext: { owner, _ in
                        if cell.selectedRawValue.value != nil {
                            cell.pickerButton.didTapButtonStream.accept(())
                        } else {
                            owner.showAlert(element.alertMessage ?? "", completionHandler: {
                                cell.pickerButton.didTapButtonStream.accept(())
                            })
                        }
                    })
                    .disposed(by: cell.disposeBag)
            }.disposed(by: disposeBag)
        
        nextButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                let bmiViewController = BMIViewController()
                owner.navigationController?.pushViewController(bmiViewController, animated: true)
            }).disposed(by: disposeBag)
    }
    
    private func showAlert(_ message: String, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(
            title: "권장 값 변경하기",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(
            title: "취소",
            style: .cancel
        ))
        alert.addAction(UIAlertAction(
            title: "확인",
            style: .default,
            handler: { _ in
                completionHandler()
        }))
        present(alert, animated: true)
    }
}
