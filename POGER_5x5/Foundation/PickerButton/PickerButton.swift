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
    
    let modelStream = PublishRelay<InputRequirable>()
    
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
            .map { $0.dataSource }
            .bind(to: pickerView.rx.itemTitles) { $1 }
            .disposed(by: disposeBag)
        
        self.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.didTapButton()
            }).disposed(by: disposeBag)
        
        toolbar.doneButton.rx.tap
            .withLatestFrom(modelStream)
            .map {  $0.unit }
            .withUnretained(self)
            .subscribe(onNext: { owner, unit in
                let result = owner.didTapDone()
                owner.setTitle(result + " " + unit, for: .normal)
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
    
    private func didTapDone() -> String {
        let row = pickerView.selectedRow(inComponent: pickerView.numberOfComponents - 1)
        if let title = pickerView.delegate?.pickerView?(pickerView, titleForRow: row, forComponent: pickerView.numberOfComponents) {
            return title
        } else {
            assertionFailure("Failed to get pickerView value.")
            return ""
        }
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
