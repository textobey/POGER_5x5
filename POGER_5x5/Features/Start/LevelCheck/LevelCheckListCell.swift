//
//  LevelCheckListCell.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/02/03.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class LevelCheckListCell: UITableViewCell {
    
    // MARK: - stored properties
    var disposeBag = DisposeBag()
    
    let wrapperView = UIView().then {
        $0.backgroundColor = .secondarySystemBackground
    }
    
    let typeLabel = UILabel().then {
        $0.text = "type"
        $0.textColor = .label
        $0.font = .preferredFont(forTextStyle: .body)
    }

    lazy var pickerButton: PickerButton = {
        let model = PickerButtonModel(
            dataSource: R.Weight.weightDataSource.map { "\($0)" },
            unit: "KG"
        )
        return PickerButton(model: model).then {
            $0.setTitle("20 KG", for: .normal)
            $0.titleLabel?.textAlignment = .right
            $0.contentHorizontalAlignment = .right
            $0.setTitleColor(UIColor.secondaryLabel, for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        }
    }()
    
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
    
    func configureCell(type: String) {
        typeLabel.text = type
    }
}
