//
//  SettingsViewController.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/02/07.
//

import UIKit
import RxSwift

class SettingsViewController: UIViewController {
    
    private let provider: ServiceProviderType
    
    private let disposeBag = DisposeBag()
    
    init(provider: ServiceProviderType) {
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
