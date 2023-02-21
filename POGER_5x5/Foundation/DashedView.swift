//
//  DashedView.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/02/21.
//

import UIKit

// TODO: 후에 UIKit Foundation으로 옮기기..해당 프로젝트에선 사용될곳이 없어보임
class DashedView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        drawDashedLine()
    }

    func drawDashedLine() {
        let lineLayer = CAShapeLayer()
        lineLayer.strokeColor = UIColor.systemGreen.withAlphaComponent(0.6).cgColor
        lineLayer.lineWidth = 2
        lineLayer.lineDashPattern = [2, 6]
        let path = CGMutablePath()
        path.addLines(
            between: [
                CGPoint(x: 3, y: (bounds.height / 2) - 17),
                CGPoint(x: bounds.width, y: (bounds.height / 2) - 17)
            ]
        )
        lineLayer.path = path
        layer.addSublayer(lineLayer)
    }
}
