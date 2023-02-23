//
//  IntputCategory.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/02/22.
//

import Foundation

protocol Questionnaire {
    var category: String { get }
    var dataSource: [String] { get }
    var placeholder: String { get }
    var unit: String { get }
    var alertMessage: String? { get }
    func filterUnit() -> String
}

extension Questionnaire where Self: RawRepresentable, RawValue == String {
    var category: String {
        return rawValue
    }
    
    func filterUnit() -> String {
        return placeholder.replacingOccurrences(
            of: unit,
            with: ""
        ).trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

enum Training: String, Questionnaire, CaseIterable {
    case squat = "스쿼트"
    case benchpress = "벤치프레스"
    case deadlift = "데드리프트"
    case pendlayrow = "펜들레이로우"
    case overheadpress = "오버헤드프레스"
    
    var dataSource: [String] {
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

enum Precondition: String, Questionnaire, CaseIterable {
    case rep = "횟수"
    case weightGap = "세트 간 무게차이"
    case minimumPlate = "가장 작은 원판의 무게"
    case originalLevel = "본인의 기록과 같아지는 훈련의 주"
    
    var dataSource: [String] {
        switch self {
        case .rep: return R.Weight.repDataSource.map { "\($0)" }
        case .weightGap: return R.Weight.weightGapDataSource.map { "\($0)" }
        case .minimumPlate: return R.Weight.minPlateDataSource.map { "\($0)" }
        case .originalLevel: return R.Weight.originalLevelDataSource.map { "\($0)" }
        }
    }
    
    var placeholder: String {
        switch self {
        case .rep: return "5 회"
        case .weightGap: return "12.5 %"
        case .minimumPlate: return "2.5 KG"
        case .originalLevel: return "4 주"
        }
    }
    
    var unit: String {
        switch self {
        case .rep: return R.Unit.rep
        case .weightGap: return R.Unit.per
        case .minimumPlate: return R.Unit.kg
        case .originalLevel: return R.Unit.week
        }
    }
    
    var alertMessage: String? {
        return "정말로 설정된 권장 값을 변경하시겠어요?"
    }
    
    //func isEqual(_ compare: Questionnaire) -> Bool {
    //    return self.category == compare.category && self.filterUnit() == compare.filterUnit()
    //}
}

enum Personal: String, Questionnaire, CaseIterable {
    case gender = "성별"
    case height = "신장"
    case weight = "체중"
    
    var dataSource: [String] {
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
