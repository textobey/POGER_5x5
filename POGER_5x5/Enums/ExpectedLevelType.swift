//
//  ExpectedLevelType.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/03/02.
//

import UIKit

enum ExpectedLevelType: String, CaseIterable {
    case level = "레벨"
    case maximum1Rep = "예상 1회 기록"
    case maximum3Rep = "예상 3회 기록"
    case maximum5Rep = "예상 5회 기록"
    case sbdRecord = "예상 3대 운동 기록"
    
    var icon: UIImage {
        switch self {
        case .level: return UIImage(systemName: "figure.run")!
        case .maximum1Rep: return UIImage(systemName: "1.circle")!
        case .maximum3Rep: return UIImage(systemName: "3.circle")!
        case .maximum5Rep: return UIImage(systemName: "5.circle")!
        case .sbdRecord: return UIImage(systemName: "figure.strengthtraining.traditional")!
        }
    }
}
