//
//  PickerButton.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/02/03.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit


struct PickerButtonModel {
    var dataSource: [String]
    var unit: String
}

class PickerButton: UIButton {
    
    private let disposeBag = DisposeBag()

    let model: PickerButtonModel
    
    let pickerView = UIPickerView().then {
        $0.backgroundColor = .secondarySystemBackground
    }
    
    override var inputView: UIView? {
        return pickerView
    }

    lazy var toolbar = PickerButtonToolbarView(
        frame: CGRect(
            x: 0,
            y: 0,
            width: UIScreen.main.bounds.size.width,
            height: UIScreen.main.bounds.size.height - pickerView.frame.height
        )
    )
    
    public override var inputAccessoryView: UIView? {
        return toolbar
    }
    
    public override var canBecomeFirstResponder: Bool {
        return true
    }
    
    init(model: PickerButtonModel) {
        self.model = model
        super.init(frame: .zero)
        bindRx()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func bindRx() {
        Observable.just(model.dataSource)
            .bind(to: pickerView.rx.itemTitles) { _, item in
                return item
            }
            .disposed(by: disposeBag)
        
        self.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.didTapButton()
            }).disposed(by: disposeBag)
        
        toolbar.doneButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.didTapDone()
            })
            .disposed(by: disposeBag)
        
        toolbar.outSideViewTapGesture.rx.event
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.didTapClose()
            })
            .disposed(by: disposeBag)
    }
    
    private func closePickerView() {
        DispatchQueue.main.async {
            self.titleLabel?.textColor = .secondaryLabel
        }
        UIView.animate(withDuration: 0.3) {
            self.resignFirstResponder()
        }
    }
    
    /// Close the picker view
    private func didTapClose() {
        closePickerView()
    }
    
    private func didTapDone() {
        let row = pickerView.selectedRow(inComponent: pickerView.numberOfComponents - 1)
        //delegate?.pickerView(pickerView, titleForRow: row)
        if let title = pickerView.delegate?.pickerView?(pickerView, titleForRow: row, forComponent: pickerView.numberOfComponents) {
            setTitle(title + " " + model.unit, for: .normal)
        } else {
            assertionFailure("Failed to get pickerView value.")
        }
        closePickerView()
    }
    
    /// Open the picker view
    private func didTapButton() {
        DispatchQueue.main.async {
            self.titleLabel?.textColor = .systemBlue
        }
        UIView.animate(withDuration: 0.3) {
            self.becomeFirstResponder()
        }
    }
}
