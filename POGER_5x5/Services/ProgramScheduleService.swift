//
//  ProgramScheduleService.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/03/13.
//

import Foundation

protocol ProgramScheduleServiceType {
    func fetchTrainingList(of day: Day) -> [Training]
    func fetchDetail(of training: Training, at day: Day) -> DayTrainingDetail
}

final class ProgramScheduleService: ProgramScheduleServiceType {
    
    let service: WeightCalculationServiceType
    
    init(service: WeightCalculationServiceType) {
        self.service = service
    }
    
    private var currentWeek: Int {
        Defaults.shared.get(for: .crWeek) ?? 1
    }
    
    func makeProgramSchedule(of day: Day) -> [DayTraining] {
        
        //let trainingList = fetchTrainingList(of: day)
        //    .map { training -> DayTrainingDetail in
        //        fetchDetail(of: training, at: day)
        //    }
        
        //trainingList.map { training in
        //    service.calculateWeight(of: training)
        //}
        
        return []
    }
    
    func fetchTrainingList(of day: Day) -> [Training] {
        switch day {
        case .day1:
            return [.squat, .benchpress, .pendlayrow , .pullups]
            
        case .day2:
            return [.deadlift, .overheadpress, .machinepress , .highbarsquat]
            
        case .day3:
            return [.squat, .benchpress, .pendlayrow , .chinups]
            
        }
    }
    
    func fetchDetail(of training: Training, at day: Day) -> DayTrainingDetail {
        switch training {
        case .squat:
            return DayTrainingDetail(
                training: training,
                rep: 6,
                mainSet: 5,
                mainSetRep: day == .day1 ? 5 : 3,
                hasfinish: true
            )
            
        case .benchpress:
            return DayTrainingDetail(
                training: training,
                rep: 6,
                mainSet: 5,
                mainSetRep: day == .day1 ? 5 : 3,
                hasfinish: true
            )
            
        case .deadlift:
            return DayTrainingDetail(
                training: training,
                rep: 4,
                mainSet: 4,
                mainSetRep: 3,
                hasfinish: false
            )
            
        case .pendlayrow:
            return DayTrainingDetail(
                training: training,
                rep: day == .day1 ? 5 : 6,
                mainSet: 5,
                mainSetRep: day == .day1 ? 5 : 3,
                hasfinish: day == .day1 ? false : true
            )
            
        case .overheadpress:
            return DayTrainingDetail(
                training: training,
                rep: 5,
                mainSet: 4,
                mainSetRep: 5,
                hasfinish: true
            )
            
        case .highbarsquat:
            return DayTrainingDetail(
                training: training,
                rep: 5,
                mainSet: nil,
                mainSetRep: nil,
                hasfinish: true
            )
            
        default:
            return DayTrainingDetail(
                training: training,
                rep: 0,
                mainSet: nil,
                mainSetRep: nil,
                hasfinish: false
            )
        }
    }
}

struct DayTrainingDetail {
    var training: Training
    var weight: CGFloat?
    var rep: Int?
    var mainSet: Int?
    var week: CGFloat?
    var day: Day?
    var mainSetRep: Int?
    var hasfinish: Bool
}
