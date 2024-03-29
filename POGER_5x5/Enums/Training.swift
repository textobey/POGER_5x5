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

    var bestRecord: CGFloat? {
        switch self {
        case .squat:
            return Defaults.shared.get(for: .sq)
            
        case .highbarsquat:
            //TODO: 전용 계산식 작성
            return 0
            
        case .benchpress:
            return Defaults.shared.get(for: .bp)
            
        case .deadlift:
            return Defaults.shared.get(for: .dl)
            
        case .pendlayrow:
            return Defaults.shared.get(for: .pr)
            
        case .overheadpress:
            return Defaults.shared.get(for: .oh)
            
        case .machinepress:
            //TODO: 전용 계산식이 필요 없을 경우 작성
            return 0
            
        default:
            //TODO: 전용 계산식이 필요 없을 경우 작성(풀업, 친업)
            return 0
        }
    }
    
    func saveInput(_ input: String) {
        guard let input = input.convertCGFloat() else { return }
        switch self {
        case .squat:
            return Defaults.shared.set(input, for: .sq)
            
        case .benchpress:
            return Defaults.shared.set(input, for: .bp)
            
        case .deadlift:
            return Defaults.shared.set(input, for: .dl)
            
        case .pendlayrow:
            return Defaults.shared.set(input, for: .pr)
            
        case .overheadpress:
            return Defaults.shared.set(input, for: .oh)
            
        default:
            break
        }
    }
}
