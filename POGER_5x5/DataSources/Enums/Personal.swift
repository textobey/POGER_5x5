//
//  Personal.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/03/02.
//

import Foundation

enum Personal: String, Questionnaire, CaseIterable {
    case gender = "성별"
    case height = "신장"
    case weight = "체중"
    
    var pickerDataSource: [String] {
        switch self {
        case .gender: return R.Weight.genderDataSoruce
        case .height: return R.Weight.humanHeightDataSource.map { "\($0)" }
        case .weight: return R.Weight.humanWeightDataSource.map { "\($0)" }
        }
    }
    
    var placeholder: String {
        switch self {
        case .gender: return "남자"
        case .weight: return "73 KG"
        case .height: return "172 CM"
        }
    }
    
    var unit: String {
        switch self {
        case .gender: return ""
        case .weight: return R.Unit.kg
        case .height: return R.Unit.cm
        }
    }
    
    var alertMessage: String? {
        return nil
    }
}
