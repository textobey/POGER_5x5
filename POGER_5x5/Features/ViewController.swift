//
//  ViewController.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/02/02.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let viewController2 = ViewController2()
        let navigationController = UINavigationController(rootViewController: viewController2)
        navigationController.modalPresentationStyle = .overFullScreen
        self.present(navigationController, animated: true)
    }
}

