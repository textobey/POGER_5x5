//
//  Resource.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/02/03.
//

import Foundation

struct R {
    struct Margin { }
    struct Weight { }
    struct Unit { }
    struct Expectation { }
    struct Process { }
}

extension R.Margin {
    static let paddingLeft: CGFloat = 20.0
    static let paddingRight: CGFloat = 20.0
}

extension R.Weight {
    static let weightDataSource: [Int] = Array(20 ... 455)
    static let weightGapDataSource: [CGFloat] = stride(from: 5.0, through: 30.0, by: 0.5).map { CGFloat($0) }
    static let repDataSource: [Int] = Array(1 ... 10)
    static let genderDataSoruce: [String] = ["남자", "여자", "기타", "선택하고 싶지 않음"]
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
        DayTraining(rep: "5x", weight: "35", training: .squat),
        DayTraining(rep: "5x", weight: "35", training: .benchpress),
        DayTraining(rep: "5x", weight: "35", training: .pendlayrow),
        DayTraining(rep: "4x", weight: "최대한", training: .pullups)
    ]
    
    static let day2DataSource: [DayTraining] = [
        DayTraining(rep: "5x", weight: "35", training: .deadlift),
        DayTraining(rep: "5x", weight: "35", training: .overheadpress),
        DayTraining(rep: "5x", weight: "35", training: .machinepress),
        DayTraining(rep: "4x", weight: "최대한", training: .highbarsquat)
    ]
    
    static let day3DataSource: [DayTraining] = [
        DayTraining(rep: "5x", weight: "35", training: .squat),
        DayTraining(rep: "5x", weight: "35", training: .benchpress),
        DayTraining(rep: "5x", weight: "35", training: .pendlayrow),
        DayTraining(rep: "4x", weight: "최대한", training: .chinups)
    ]
}
