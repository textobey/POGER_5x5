//
//  TrainingProcessDecorationView.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/03/03.
//

import UIKit
import SnapKit

class TrainingProcessDecorationView: UICollectionReusableView {
    
    static let identifier = String(describing: TrainingProcessDecorationView.self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        self.backgroundColor = .secondarySystemBackground
    }
}
