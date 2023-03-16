//
//  DefaultsKey+.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/03/10.
//

import Foundation

extension DefaultsKey {
    
    //MARK: Foundations
    
    /// 현재 진행하고 있는 훈련의 주(Week)
    static let crWeek = Key<CGFloat>("CRWEEK")
    
    /// 훈련 반복 횟수
    static let rep = Key<CGFloat>("REP")
    
    /// 훈련간의 무게 차이(%)
    static let interval = Key<CGFloat>("INTERVAL")
    
    /// 체육관에서 가장 작은 원판의 무게
    static let plate = Key<CGFloat>("PLATE")
    
    /// 본인의 기록과 같아지는 훈련의 주(Week)
    static let prWeek = Key<CGFloat>("PRWEEK")
    
    /// 성별
    static let gender = Key<Gender>("GENDER")
    
    /// 신장
    static let height = Key<CGFloat>("HEIGHT")
    
    /// 체중
    static let weight = Key<CGFloat>("WEIGHT")
    
    //MARK: 펜들레이로우
    
    /// 본인의 기록
    static let pr = Key<CGFloat>("PR")
    /// 예상 1회 기록
    static let prMax = Key<CGFloat>("PRMAX")
    /// 세트간 무게 차이
    //static let prInt = Key<CGFloat>("PRINT")
    /// optional
    //static let prTon = Key<CGFloat>("PRTON")
    
    //MARK: 벤치프레스
    
    /// 본인의 기록
    static let bp = Key<CGFloat>("BP")
    /// 예상 1회 기록
    static let bpMax = Key<CGFloat>("BPMAX")
    /// 세트간 무게 차이
    //static let bpInt = Key<CGFloat>("BPINT")
    
    //MARK: 데드리프트
    
    /// 본인의 기록
    static let dl = Key<CGFloat>("DL")
    /// 예상 1회 기록
    static let dlMax = Key<CGFloat>("DLMAX")
    /// 세트간 무게 차이
    //static let dlInt = Key<CGFloat>("DLINT")
    
    //MARK: 오버헤드프레스
    
    /// 본인의 기록
    static let oh = Key<CGFloat>("OH")
    /// 예상 1회 기록
    static let ohMax = Key<CGFloat>("OHMAX")
    /// 세트간 무게 차이
    //static let ohInt = Key<CGFloat>("OHINT")
    
    //MARK: 스쿼트
    
    /// 본인의 기록
    static let sq = Key<CGFloat>("SQ")
    /// 예상 1회 기록
    static let sqMax = Key<CGFloat>("SQMAX")
    /// 세트간 무게 차이
    //static let sqInt = Key<CGFloat>("SQINT")
    
}
