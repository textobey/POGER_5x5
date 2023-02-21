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

    lazy var pickerButton = PickerButton().then {
        $0.setTitle("20", for: .normal)
        $0.setTitleColor(UIColor.secondaryLabel, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        $0.pickerViewDelegate = self
        $0.pickerViewDataSource = self
    }
    
    let kgLabel = UILabel().then {
        $0.text = "KG"
        $0.textAlignment = .right
        $0.textColor = .secondaryLabel
        $0.font = .systemFont(ofSize: 16, weight: .regular)
    }
    
    // MARK: - initialze method
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
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
        
        wrapperView.addSubview(kgLabel)
        kgLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview()
        }
        
        wrapperView.addSubview(pickerButton)
        pickerButton.snp.makeConstraints {
            $0.trailing.equalTo(kgLabel.snp.leading).offset(-2)
            $0.centerY.equalToSuperview()
        }
    }
    
    func configureCell(type: String) {
        typeLabel.text = type
    }
}

extension LevelCheckListCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return R.Weight.weightDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(R.Weight.weightDataSource[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("didSelect", R.Weight.weightDataSource[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow: Int) {
        print("Done Button Detected", R.Weight.weightDataSource[titleForRow])
    }
}

