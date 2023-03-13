//
//  UIBaseViewController.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/03/13.
//

import UIKit
import RxSwift

class UIBaseViewController: UIViewController {
    
    let provider: ServiceProviderType
    
    var disposeBag = DisposeBag()
    
    init(provider: ServiceProviderType) {
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
