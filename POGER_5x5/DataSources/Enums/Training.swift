//
//  Training.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/03/02.
//

import Foundation

enum Training: String, Questionnaire, CaseIterable {
    case squat = "스쿼트"
    case highbarsquat = "하이바스쿼트"
    case benchpress = "벤치프레스"
    case deadlift = "데드리프트"
    case pendlayrow = "펜들레이로우"
    case overheadpress = "오버헤드프레스"
    case pullups = "턱걸이"
    case chinups = "친업"
    case machinepress = "머신프레스"
    
    static let weightTop5: [Training] = [.squat, .benchpress, .deadlift, .pendlayrow, .overheadpress]
    
    var pickerDataSource: [String] {
        return R.Weight.weightDataSource.map { "\($0)" }
    }
    
    var placeholder: String {
        return "20 KG"
    }
    
    var unit: String {
        return R.Unit.kg
    }
    
    var alertMessage: String? {
        return nil
    }
}
