//
//  TrainingSectionModel.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/02/15.
//

import Foundation
import RxDataSources

struct Training {
    let name: String
    let weight: String
}

struct Week {
    let number: String
}

enum TrainingViewSection {
    case week(items: [TrainingViewSectionItem])
    case training(day: String, items: [TrainingViewSectionItem])
}

enum TrainingViewSectionItem {
    case week(Week)
    case training(Training)
}

extension TrainingViewSection: SectionModelType {
    
    typealias Item = TrainingViewSectionItem
    
    var days: String {
        switch self {
        case .week:
            return ""
            
        case .training(let day, _):
            return day
        }
    }
    
    var items: [TrainingViewSectionItem] {
        switch self {
        case .week(let items):
            return items
            
        case .training(_, let items):
            return items
        }
    }
    
    init(original: TrainingViewSection, items: [TrainingViewSectionItem]) {
        switch original {
        case .week(let items):
            self = .week(items: items)
            
        case .training(let day, let items):
            self = .training(day: day, items: items)
        }
    }
}
