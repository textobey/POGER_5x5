//
//  Gender.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/03/10.
//

import Foundation

enum Gender: String, Codable, CaseIterable {
    case male = "남자"
    case female = "여자"
    case etc = "기타"
    case wont = "선택하고 싶지 않음"
}
