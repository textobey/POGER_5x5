//
//  WeightCalculationService.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/03/13.
//

import Foundation

protocol WeightCalculationServiceType {
    func calculateWeight(of training: DayTrainingDetail) -> CGFloat
}

final class WeightCalculationService: WeightCalculationServiceType {
    
    private var currentWeek: Int {
        Defaults.shared.get(for: .crWeek) ?? 1
    }
    
    private var minPlate: CGFloat {
        Defaults.shared.get(for: .plate)!
    }
    
    func calculateWeight(of training: DayTrainingDetail) -> CGFloat {
        // 특정 운동에 대한 나의 1RM
        let oneRM = training.training.bestRecord!
        let differ = training.training.weightDifference!
        
        return 0
        
        //guard turn != .main else {
        //    return round(oneRM * pow(1.025, CGFloat(currentWeek - 1)) / (2 * minPlate)) * (2 * minPlate)
        //}
        
        //let mainWeight = calculateWeight(of: training, turn: .main)
        
        //return round(mainWeight * (1 - differ * CGFloat(5 - turn.rawValue)) / (2 * minPlate)) * (2 * minPlate)
    }
}

// TODO: 계산식
// first : round(main 무게값 * (1 - sqint * 4) / (2 * minPlate)) * (2 * minPlate)
// second: round(main 무게값 * (1 - sqint * 3) / (2 * minPlate)) * (2 * minPlate)
// third : round(main 무게값 * (1 - sqint * 2) / (2 * minPlate)) * (2 * minPlate)
// fourth: round(main 무게값 * (1 - sqint * 1) / (2 * minPlate)) * (2 * minPlate)
// main  : round(main 무게값 * pow(1.025, (currentWeak - 1)) / (2 * minPlate)) * (2 * minPlate)
// finish: round(main 무게값 * (1 - sqint * 3) / (2 * minPlate)) * (2 * minPlate)

// 주의점
// 1. 메인운동 계산 과정에서 Day3 스케줄 ? currentWeek : currentWeek - 1
// 2. 운동별로 main 세트가 4번째인 경우가 있음(DL, OHP 등)
// 3. 다른 계산식이 필요한 운동이 있음(하이바)
// 4. 계산식이 필요하지 않은 운동이 있음(머신프레스, 턱걸이, 친업)
// 5. 펜들레이의 경우 Day1과 Day3의 반복횟수와 세트수가 다름
