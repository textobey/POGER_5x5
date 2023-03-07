//
//  Questionnaire.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/03/02.
//

import Foundation

protocol Questionnaire {
    var category: String { get }
    var pickerDataSource: [String] { get }
    var placeholder: String { get }
    var unit: String { get }
    var alertMessage: String? { get }
    func filterUnit() -> String
}

extension Questionnaire where Self: RawRepresentable, RawValue == String {
    var category: String {
        return rawValue
    }
    
    func filterUnit() -> String {
        return placeholder.replacingOccurrences(
            of: unit,
            with: ""
        ).trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
