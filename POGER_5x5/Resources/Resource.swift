//
//  Resource.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/02/03.
//

import Foundation

struct Resource {
    struct Weight { }
}

extension Resource.Weight {
    static let weightDataSource: [Int] = (0 ..< 455).map { $0 }
}
