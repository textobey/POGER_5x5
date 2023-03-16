//
//  ProgramScheduleService.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/03/13.
//

import Foundation

protocol ProgramScheduleServiceType {
    func makeProgramSchedule(of day: Day) -> [[DayTraining]]
    func fetchSchedule(of day: Day) -> [Training]
    func fetchModel(of training: Training, at day: Day) -> [DayTraining]
}

final class ProgramScheduleService: BaseService, ProgramScheduleServiceType {
    
    private var currentWeek: Int {
        Int(Defaults.shared.get(for: .crWeek) ?? 1)
    }
    
    func makeProgramSchedule(of day: Day) -> [[DayTraining]] {
        return fetchSchedule(of: day).map { dayTraining in
            return fetchModel(of: dayTraining, at: day)
        }
    }
    
    func fetchSchedule(of day: Day) -> [Training] {
        switch day {
        case .day1:
            return [.squat, .benchpress, .pendlayrow , .pullups]
            
        case .day2:
            return [.deadlift, .overheadpress, .machinepress , .highbarsquat]
            
        case .day3:
            return [.squat, .benchpress, .pendlayrow , .chinups]
        }
    }
    
    func fetchModel(of training: Training, at day: Day) -> [DayTraining] {
        switch training {
        case .squat:
            return Array(
                repeating: DayTraining(
                    training: training,
                    rep: 5,
                    mainSet: 5,
                    mainSetRep: day == .day1 ? 5 : 3,
                    hasfinish: true
                ),
                count: 6
            )
            
        case .benchpress:
            return Array(
                repeating: DayTraining(
                    training: training,
                    rep: 5,
                    mainSet: 5,
                    mainSetRep: day == .day1 ? 5 : 3,
                    hasfinish: true
                ),
                count: 6
            )
            
        case .deadlift:
            return Array(
                repeating: DayTraining(
                    training: training,
                    rep: 5,
                    mainSet: 5,
                    mainSetRep: day == .day1 ? 5 : 3,
                    hasfinish: false
                ),
                count: 4
            )
            
        case .pendlayrow:
            return Array(
                repeating: DayTraining(
                    training: training,
                    rep: 5,
                    mainSet: 5,
                    mainSetRep: day == .day1 ? 5 : 3,
                    hasfinish: day == .day1 ? false : true
                ),
                count: day == .day1 ? 5 : 6
            )
            
        case .overheadpress:
            return Array(
                repeating: DayTraining(
                    training: training,
                    rep: 5,
                    mainSet: 4,
                    mainSetRep: 5,
                    hasfinish: true
                ),
                count: 5
            )
            
        case .highbarsquat:
            return Array(
                repeating: DayTraining(
                    training: training,
                    rep: 5,
                    mainSet: nil,
                    mainSetRep: nil,
                    hasfinish: true
                ),
                count: 5
            )
            
        case .machinepress:
            return Array(
                repeating: DayTraining(
                    training: training,
                    rep: 10,
                    mainSet: nil,
                    mainSetRep: nil,
                    hasfinish: day == .day1 ? false : true
                ),
                count: 4
            )
            
        default:
            return Array(
                repeating: DayTraining(
                    training: training,
                    rep: nil,
                    mainSet: nil,
                    mainSetRep: nil,
                    hasfinish: false
                ),
                count: 4
            )
        }
    }
}
