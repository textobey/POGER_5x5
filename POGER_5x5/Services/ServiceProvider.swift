//
//  ServiceProvider.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/03/13.
//

import Foundation

/// 의존관계는 있으나 주종관계는 없어보이는 구조.. 클린아키텍처 구조로 보았을때 내부계층에서 외부계층에 대한 핸들링이 없다. DIP는 아니다

protocol ServiceProviderType {
    var programScheduleService: ProgramScheduleServiceType { get }
    var weightCalculationService: WeightCalculationServiceType { get }
}

final class ServiceProvider: ServiceProviderType {
    lazy var programScheduleService: ProgramScheduleServiceType = ProgramScheduleService(service: weightCalculationService)
    var weightCalculationService: WeightCalculationServiceType = WeightCalculationService()
}
