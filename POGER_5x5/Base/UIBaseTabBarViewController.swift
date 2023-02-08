//
//  UIBaseTabBarViewController.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/02/08.
//

import UIKit

final class UIBaseTabBarController: UITabBarController {
    
    fileprivate enum UIComponets {
        static let rootViewControllers = [
            TrainingViewController(),
            LevelTrendViewController(),
            SettingsViewController()
        ]
        
        static let tabBarItems = [
            UITabBarItem(title: "운동", image: UIImage(systemName: "figure.strengthtraining.traditional"), tag: 0),
            UITabBarItem(title: "트렌드", image: UIImage(systemName: "chart.line.uptrend.xyaxis"), tag: 1),
            UITabBarItem(title: "설정", image: UIImage(systemName: "gearshape"), tag: 2),
        ]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = fetchRootViewControllers()
        self.setupTabBarController()
    }
    
    private func setupTabBarController() {
        self.selectedIndex = 0
        //TODO: tabBarItem selected color 정하기
        //TODO: tabBar 영역 컨텐츠에 따른 불투명도 표시 확인하기
        //self.tabBar.isTranslucent = true
        //self.tabBar.backgroundColor = .tertiarySystemBackground
        //self.tabBar.items?.forEach { $0.image?.withTintColor(.white) }
    }
    
    private func fetchRootViewControllers() -> [UINavigationController] {
        return UIComponets.rootViewControllers.enumerated().map { index, rootViewController -> UINavigationController in
            rootViewController.view.backgroundColor = .systemBackground
            rootViewController.tabBarItem = UIComponets.tabBarItems[index]
            
            let navigationController = UINavigationController(rootViewController: rootViewController)
            navigationController.navigationBar.topItem?.title = UIComponets.tabBarItems[index].title
            navigationController.navigationBar.prefersLargeTitles = true
            
            let style = NSMutableParagraphStyle()
            style.firstLineHeadIndent = 8
            UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.paragraphStyle: style]
            
            return navigationController
        }
    }
}

