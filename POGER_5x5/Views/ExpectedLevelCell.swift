//
//  ExpectedLevelCell.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/02/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ExpectedLevelCell: UITableViewCell {

    // MARK: - stored properties
    
    var disposeBag = DisposeBag()
    
    //var model: Expectation? {
    //    willSet {
    //        guard let newValue = newValue else { return }
    //        informationIcon.image = newValue.type.icon
    //    }
    //}
    
    let wrapperView = UIView().then {
        $0.backgroundColor = .secondarySystemBackground
        $0.layer.cornerRadius = 12
    }
    
    let informationIcon = UIImageView().then {
        //$0.image = UIImage(systemName: "figure.run")
        $0.tintColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let informationTitle = UILabel().then {
        $0.textColor = .secondaryLabel
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
    
    let expectedLevel = UILabel().then {
        $0.textColor = .systemGreen
        $0.font = .systemFont(ofSize: 18, weight: .medium)
        $0.textAlignment = .left
        $0.numberOfLines = 0
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
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-12)
            $0.height.equalTo(64)
        }
        
        wrapperView.addSubview(informationIcon)
        informationIcon.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }
        
        wrapperView.addSubview(informationTitle)
        informationTitle.snp.makeConstraints {
            $0.bottom.equalTo(wrapperView.snp.centerY).offset(-2)
            $0.leading.equalTo(informationIcon.snp.trailing).offset(14)
        }
        
        wrapperView.addSubview(expectedLevel)
        expectedLevel.snp.makeConstraints {
            $0.top.equalTo(informationTitle.snp.bottom)
            $0.leading.equalTo(informationTitle)
        }
    }
    
    func configureCell(_ model: Expectation) {
        informationIcon.image = model.type.icon
        informationTitle.text = model.type.rawValue
        expectedLevel.text = model.record
    }
}
