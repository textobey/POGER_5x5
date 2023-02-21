//
//  UIView+.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/02/20.
//

import UIKit

extension UIView {
    var snapshot: UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        let capturedImage = renderer.image { context in
            layer.render(in: context.cgContext)
        }
        return capturedImage
    }
}
