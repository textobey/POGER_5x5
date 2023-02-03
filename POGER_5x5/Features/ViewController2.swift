//
//  ViewController2.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/02/02.
//

import UIKit

class ViewController2: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let viewController3 = ViewController3()
        self.navigationController?.pushViewController(viewController3, animated: true)
    }
}
    
