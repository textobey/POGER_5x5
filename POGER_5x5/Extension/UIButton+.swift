//
//  UIButton+.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/02/06.
//

import UIKit

extension UIButton {
    static func commonButton(title: String) -> UIButton {
        return UIButton().then {
            $0.setTitle(title, for: .normal)
            $0.setTitleColor(.label, for: .normal)
            $0.titleLabel?.font = .notoSans(size: 18, style: .bold)
            $0.titleLabel?.textAlignment = .center
            $0.backgroundColor = .tertiarySystemBackground
            $0.layer.cornerRadius = 16
        }
    }
}
