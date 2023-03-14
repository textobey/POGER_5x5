//
//  Resource.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/02/03.
//

import UIKit

struct R {
    struct Margin { }
    struct Weight { }
    struct Unit { }
    struct Expectation { }
    struct Process { }
    struct SFSymbol { }
}

extension R.Margin {
    static let paddingLeft: CGFloat = 20.0
    static let paddingRight: CGFloat = 20.0
}

extension R.Weight {
    static let weightDataSource: [Int] = Array(20 ... 455)
    static let weightGapDataSource: [CGFloat] = stride(from: 5.0, through: 30.0, by: 0.5).map { CGFloat($0) }
    static let repDataSource: [Int] = Array(1 ... 10)
    static let genderDataSoruce: [String] = Gender.allCases.map { $0.rawValue }
    static let minPlateDataSource: [CGFloat] = [1.25, 2.5, 5, 10]
    static let originalLevelDataSource: [Int] = Array(1 ... 12)
    static let humanHeightDataSource: [Int] = Array(80 ... 200)
    static let humanWeightDataSource: [Int] = Array(30 ... 200)
}

extension R.Unit {
    static let kg = "KG"
    static let cm = "CM"
    static let rep = "회"
    static let per = "%"
    static let day = "일"
    static let week = "주"
}

extension R.Process {
    //TODO: 각 Day별로 계산식에 따라 12개(12주)치를 만드는 로직이 필요해보임
    static let day1DataSource: [DayTraining] = [
        DayTraining(training: .squat, weight: 35, rep: 6),
        DayTraining(training: .benchpress, weight: 35, rep: 6),
        DayTraining(training: .pendlayrow, weight: 35, rep: 5),
        DayTraining(training: .pullups, weight: -1, rep: -1)
    ]
    
    static let day2DataSource: [DayTraining] = [
        DayTraining(training: .deadlift, weight: 35, rep: 6),
        DayTraining(training: .overheadpress, weight: 35, rep: 6),
        DayTraining(training: .machinepress, weight: 35, rep: 5),
        DayTraining(training: .highbarsquat, weight: -1, rep: -1)
    ]
    
    static let day3DataSource: [DayTraining] = [
        DayTraining(training: .squat, weight: 35, rep: 6),
        DayTraining(training: .benchpress, weight: 35, rep: 6),
        DayTraining(training: .pendlayrow, weight: 35, rep: 5),
        DayTraining(training: .chinups, weight: -1, rep: -1)
    ]
}

extension R.SFSymbol {
    static let goforwardFive = UIImage(systemName: "goforward.5")!
    static let goforwardPlus = UIImage(systemName: "goforward.plus")!
}
