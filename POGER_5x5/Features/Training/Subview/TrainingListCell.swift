//
//  TrainingListCell.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/02/10.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class TrainingListCell: UITableViewCell {
    
    // MARK: - stored properties
    static let identifier = String(describing: TrainingListCell.self)
    
    var disposeBag = DisposeBag()
    
    let wrapperView = UIView().then {
        $0.backgroundColor = .tertiarySystemBackground
        $0.layer.cornerRadius = 12
    }
    
    let dayLabel = UILabel().then {
        $0.text = "DAY 1"
        $0.textColor = .label
        $0.font = .preferredFont(forTextStyle: .title3)
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
        contentView.addSubview(dayLabel)
        dayLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        contentView.addSubview(wrapperView)
        wrapperView.snp.makeConstraints {
            $0.top.equalTo(dayLabel.snp.bottom).offset(18)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().offset(-22)
            $0.height.equalTo(140)
        }
    }
    
    func configureCell(day: String) {
        dayLabel.text = day
    }
}
