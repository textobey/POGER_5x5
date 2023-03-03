//
//  TrainingProcessCell.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/03/02.
//

import UIKit
import SnapKit

class TrainingProcessCell: UICollectionViewCell {
    
    static let identifier = String(describing: TrainingProcessCell.self)
    
    let wrapperView = UIView().then {
        $0.backgroundColor = .secondarySystemBackground
    }
    
    //TODO: separator를 추가했을때, 터치 영역이 전체보다는 개별 Cell로 보이는듯한 UX가 되어버려서 결정이 필요함
    let separator = UIView().then {
        $0.isHidden = true
        $0.backgroundColor = .tertiarySystemBackground
    }
    
    //TODO: label을 사용할지 vs image를 사용해서 아이콘을 보여줄지 결정이 필요함
    //let repLabel = UILabel().then {
    //    $0.text = "5x"
    //    $0.textColor = .label
    //    $0.textAlignment = .center
    //    $0.numberOfLines = 1
    //    $0.font = .preferredFont(forTextStyle: .body)
    //}
    
    let repIcon = UIImageView().then {
        $0.image = UIImage()
        $0.backgroundColor = .clear
        $0.tintColor = .systemGray
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let trainingNameLabel = UILabel().then {
        $0.textColor = .label
        $0.textAlignment = .left
        $0.numberOfLines = 1
        $0.font = .preferredFont(forTextStyle: .body)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.addSubview(wrapperView)
        wrapperView.snp.makeConstraints {
            $0.directionalEdges.equalToSuperview()
        }
        
        wrapperView.addSubview(repIcon)
        repIcon.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().offset(16)
            $0.size.equalTo(24)
        }
        
        wrapperView.addSubview(trainingNameLabel)
        trainingNameLabel.snp.makeConstraints {
            $0.centerY.equalTo(repIcon)
            $0.leading.equalTo(repIcon.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().offset(-10)
        }

        contentView.addSubview(separator)
        separator.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    func configureCell(_ model: DayTraining) {
        repIcon.image = model.rep
        trainingNameLabel.text = model.training.rawValue
        //separator.isHidden = false
    }
    
    func appendCornerRadius(at direction: Direction) {
        if case .top = direction {
            wrapperView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            wrapperView.layer.cornerRadius = 12
        } else if case .bottom = direction {
            wrapperView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            wrapperView.layer.cornerRadius = 12
            //separator.isHidden = true
        }
    }
}
