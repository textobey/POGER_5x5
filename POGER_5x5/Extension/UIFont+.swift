//
//  UIFont+.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/02/03.
//

import UIKit

// TODO: Custom Font 사용 보류, System Font로 전환 HIG > Typography 준수하도록 수정
//extension UIFont {
//    enum NotoSansStyle: String {
//        case regular = "NotoSansKR-Regular"
//        case medium = "NotoSansKR-Medium"
//        case bold = "NotoSansKR-Bold"
//    }
//
//    enum MontserratStyle: String {
//        case regular = "Montserrat-Regular"
//        case medium = "Montserrat-Medium"
//        case bold = "Montserrat-Bold"
//    }
//
//    static func notoSans(size: CGFloat, style: NotoSansStyle = .regular) -> UIFont {
//        return UIFont(name: style.rawValue, size: size)!
//    }
//
//    static func montserrat(size: CGFloat, style: MontserratStyle = .regular) -> UIFont {
//        return UIFont(name: style.rawValue, size: size)!
//    }
//}

// Apple's dynamic type sizes Large(Default)
//Large (Default)
//Style    Weight    Size (points)    Leading (points)
//Large Title    Regular    34    41
//Title 1    Regular    28    34
//Title 2    Regular    22    28
//Title 3    Regular    20    25
//Headline    Semibold    17    22
//Body    Regular    17    22
//Callout    Regular    16    21
//Subhead    Regular    15    20
//Footnote    Regular    13    18
//Caption 1    Regular    12    16
//Caption 2    Regular    11    13
//Point size based on image resolution of 144ppi for @2x and 216ppi for @3x designs.
