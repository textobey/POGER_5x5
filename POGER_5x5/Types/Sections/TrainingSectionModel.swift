//
//  TrainingSectionModel.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/02/15.
//

import Foundation
import RxDataSources

enum TrainingViewSection {
    case training(title: String, items: [TrainingViewSectionItem])
}

enum TrainingViewSectionItem {
    case training(DayTrainingDetail)
}

extension TrainingViewSection: SectionModelType {
    
    typealias Item = TrainingViewSectionItem
    
    var items: [TrainingViewSectionItem] {
        switch self {
        case .training(_, let items):
            return items
        }
    }
    
    init(original: TrainingViewSection, items: [TrainingViewSectionItem]) {
        switch original {
        case .training(let title, let items):
            self = .training(title: title, items: items)
        }
    }
}
