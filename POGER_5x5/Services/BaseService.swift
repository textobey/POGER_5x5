//
//  BaseService.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/03/15.
//

import Foundation

class BaseService {
    unowned let provider: ServiceProviderType
    
    init(provider: ServiceProviderType) {
        self.provider = provider
    }
}
