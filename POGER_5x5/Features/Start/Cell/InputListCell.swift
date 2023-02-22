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
        pickerButton.pickerView.rx.modelSelected(String.self)
            .subscribe(onNext: { model in
                print(model)
            })
            .disposed(by: disposeBag)
    }
    
    func configureCell(model: InputRequirable) {
        typeLabel.text = model.category
        pickerButton.setTitle(model.placeholder, for: .normal)
        pickerButton.modelStream.accept(model)
        selectDefaultRow(model)
    }

    private func selectDefaultRow(_ model: InputRequirable) {
        let placeholder = model.placeholder.replacingOccurrences(
            of: model.unit,
            with: ""
        ).trimmingCharacters(in: .whitespacesAndNewlines)
        
        if let row = model.dataSource.firstIndex(of: placeholder) {
            pickerButton.pickerView.selectRow(row, inComponent: 0, animated: false)
        }
    }
}
