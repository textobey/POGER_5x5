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
    
    private let pickerView = UIPickerView().then {
        $0.backgroundColor = .secondarySystemBackground
    }
    
    public var pickerViewDelegate: UIPickerViewDelegate? {
        get {
            return pickerView.delegate
        }
        set {
            return pickerView.delegate = newValue
        }
    }
    
    public var pickerViewDataSource: UIPickerViewDataSource? {
        get {
            return pickerView.dataSource
        }
        set {
            return pickerView.dataSource = newValue
        }
    }
    
    override var inputView: UIView? {
        return pickerView
    }
    
    private let closeButton = UIBarButtonItem(
        title: "Close",
        style: .plain,
        target: nil,
        action: nil
    )
    
    private let space = UIBarButtonItem(
        barButtonSystemItem: .flexibleSpace,
        target: nil,
        action: nil
    )
    
    private let doneButton = UIBarButtonItem(
        title: "Done",
        style: .done,
        target: nil,
        action: nil
    )
    
    private lazy var toolbar = UIView().then {
        let button = UIButton()
        button.setTitle("Done", for: .normal)
        button.setTitleColor(UIColor.label, for: .normal)
        $0.addSubview(button)
        button.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-12)
            $0.centerY.equalToSuperview()
        }
        button.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.didTapDone()
            })
            .disposed(by: disposeBag)
        $0.backgroundColor = .tertiarySystemBackground
        $0.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 44)
    }
    
    public override var inputAccessoryView: UIView? {
        return toolbar
    }
    
    public override var canBecomeFirstResponder: Bool {
        return true
    }
    
    // MARK: - Variables
    
    private var closeButtonTitle: String = "Close"
    private var doneButtonTitle: String = "Done"
    private var closeButtonTintColor: UIColor = .white
    private var doneButtonTintColor: UIColor = .white
    
    // MARK: - Initializer
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        bind()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    // MARK: - Public Methods
    
    public func reloadData() {
        pickerView.reloadAllComponents()
    }
    
    public func setTitleForCloseButton(_ title: String, color: UIColor = .systemBlue) {
        closeButtonTitle = title
        closeButtonTintColor = color
    }
    
    public func setTitleForDoneButton(_ title: String, color: UIColor = .systemBlue) {
        doneButtonTitle = title
        doneButtonTintColor = color
    }
    
//    public func setBackgroundColorForPicker(color: UIColor) {
//        pickerView.backgroundColor = color
//    }
    
    // MARK: - Private Methods
    
    private func configureView() {
        pickerView.delegate = pickerViewDelegate
        pickerView.dataSource = pickerViewDataSource
    }
    
    private func bind() {
        self.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.didTapButton()
            }).disposed(by: disposeBag)
    }
    
    private func closePickerView() {
        resignFirstResponder()
    }
    
    /// Close the picker view
    private func didTapClose(_ button: UIBarButtonItem) {
        closePickerView()
    }
    
    private func didTapDone() {
        let row = pickerView.selectedRow(inComponent: pickerView.numberOfComponents - 1)
        //delegate?.pickerView(pickerView, titleForRow: row)
        if let title = pickerView.delegate?.pickerView?(pickerView, titleForRow: row, forComponent: pickerView.numberOfComponents) {
            setTitle(title, for: .normal)
        } else {
            assertionFailure("Failed to get pickerView value.")
        }
        closePickerView()
    }
    
    /// Open the picker view
    private func didTapButton() {
        becomeFirstResponder()
    }
}
