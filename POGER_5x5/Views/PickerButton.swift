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

class PickerButton: UIButton {
    
    private let disposeBag = DisposeBag()
    
    /// Initial Model of PickerButton
    let modelStream = BehaviorRelay<Questionnaire?>(value: nil)
    /// PickerButton Tap Event Stream
    let didTapButtonStream = PublishRelay<Void>()
    /// Selected value from PickerButton
    let selectedStream = BehaviorRelay<String?>(value: nil)
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bindRx()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func bindRx() {
        modelStream
            .compactMap { $0?.pickerDataSource }
            .bind(to: pickerView.rx.itemTitles) { $1 }
            .disposed(by: disposeBag)
        
        selectedStream
            .withUnretained(self)
            .subscribe { owner, value in
                guard let value = value, let unit = owner.modelStream.value?.unit else { return }
                owner.setTitle(value + " " + unit, for: .normal)
            }
            .disposed(by: disposeBag)
        
        didTapButtonStream
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.didTapButton()
            })
            .disposed(by: disposeBag)
        
        toolbar.doneButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, unit in
                owner.didTapDone()
                owner.closePickerView()
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
        if let title = pickerView.delegate?.pickerView?(pickerView, titleForRow: row, forComponent: pickerView.numberOfComponents) {
            selectedStream.accept(title)
        } else {
            assertionFailure("Failed to get pickerView value.")
        }
    }
    
    /// Open the picker view
    private func didTapButton() {
        updateSelectedRow()
        DispatchQueue.main.async {
            self.titleLabel?.textColor = .systemBlue
        }
        UIView.animate(withDuration: 0.3) {
            self.becomeFirstResponder()
        }
    }
    
    private func updateSelectedRow() {
        if let rawValue = selectedStream.value, let row = modelStream.value?.pickerDataSource.firstIndex(of: rawValue) {
            pickerView.selectRow(row, inComponent: 0, animated: false)
        }
    }
}
