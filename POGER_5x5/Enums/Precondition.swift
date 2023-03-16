//
//  Precondition.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/03/02.
//

import Foundation

enum Precondition: String, Questionnaire, CaseIterable {
    case rep = "횟수"
    case weightGap = "세트 간 무게차이"
    case minimumPlate = "가장 작은 원판의 무게"
    case originalLevel = "본인의 기록과 같아지는 훈련의 주"
    
    var pickerDataSource: [String] {
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
        var savedData: CGFloat?
        let initialValue = filterUnit()
        
        switch self {
        case .rep:
            savedData = Defaults.shared.get(for: .rep)
            
        case .weightGap:
            savedData = Defaults.shared.get(for: .interval)
            
        case .minimumPlate:
            savedData = Defaults.shared.get(for: .plate)
            
        case .originalLevel:
            savedData = Defaults.shared.get(for: .prWeek)
        }
        
        return savedData == initialValue.convertCGFloat()
        ? "정말로 설정된 권장 값을 변경하시겠어요?"
        : nil
    }
    
    func saveInput(_ input: String) {
        guard let input = input.convertCGFloat() else { return }
        switch self {
        case .rep:
            return Defaults.shared.set(input, for: .rep)
            
        case .weightGap:
            return Defaults.shared.set(input, for: .interval)
            
        case .minimumPlate:
            return Defaults.shared.set(input, for: .plate)
            
        case .originalLevel:
            return Defaults.shared.set(input, for: .prWeek)
        }
    }
}
