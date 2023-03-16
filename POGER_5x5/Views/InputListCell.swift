//
//  InputListCell.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/02/22.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class InputListCell: UITableViewCell {

    // MARK: - stored properties
    
    var disposeBag = DisposeBag()
    
    var model: Questionnaire?
    
    let wrapperView = UIView().then {
        $0.backgroundColor = .secondarySystemBackground
    }
    
    let typeLabel = UILabel().then {
        $0.text = "주제"
        $0.textColor = .label
        $0.font = .preferredFont(forTextStyle: .body)
    }

    let pickerButton = PickerButton().then {
        $0.setTitle("선택", for: .normal)
        $0.titleLabel?.textAlignment = .right
        $0.contentHorizontalAlignment = .right
        $0.setTitleColor(UIColor.secondaryLabel, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
    }
    
    // MARK: - initialze method
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        bindRx()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }
    
    func configureCell(_ model: Questionnaire) {
        self.model = model
        typeLabel.text = model.category
        pickerButton.setTitle(model.placeholder, for: .normal)
        pickerButton.modelStream.accept(model)
        pickerButton.selectedStream.accept(model.filterUnit())
    }

    private func setupLayout() {
        contentView.addSubview(wrapperView)
        wrapperView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        wrapperView.addSubview(typeLabel)
        typeLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.bottom.equalToSuperview().inset(12)
        }
        
        wrapperView.addSubview(pickerButton)
        pickerButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview()
        }
    }
    
    private func bindRx() {
        pickerButton.selectedStream
            .compactMap { $0 }
            .withUnretained(self)
            .subscribe(onNext: { owner, value in
                owner.model?.saveInput(value)
            })
            .disposed(by: disposeBag)
    }
}
