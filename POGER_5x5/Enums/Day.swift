//
//  Day.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/03/14.
//

import Foundation

@frozen enum Day: String, CaseIterable {
    case day1 = "DAY 1"
    case day2 = "DAY 2"
    case day3 = "DAY 3"
    
    var trainingList: [Training] {
        switch self {
        case .day1:
            return [.squat, .benchpress, .pendlayrow , .pullups]
            
        case .day2:
            return [.deadlift, .overheadpress, .machinepress , .highbarsquat]
            
        case .day3:
            return [.squat, .benchpress, .pendlayrow , .chinups]
            
        }
    }
}
