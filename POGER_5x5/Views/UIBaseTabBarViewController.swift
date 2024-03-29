//
//  UIBaseTabBarViewController.swift
//  POGER_5x5
//
//  Created by 이서준 on 2023/02/08.
//

import UIKit

final class UIBaseTabBarController: UITabBarController {
    
    let provider: ServiceProviderType
    
    lazy var rootViewControllers = [
        TrainingViewController(provider: self.provider),
        SettingsViewController(provider: self.provider)
    ]
    
    let tabBarItems = [
        UITabBarItem(
            title: "운동",
            image: UIImage(systemName: "figure.strengthtraining.traditional") ?? UIImage(systemName: "figure.walk"),
            tag: 0
        ),
        UITabBarItem(
            title: "설정",
            image: UIImage(systemName: "gearshape"),
            tag: 2
        )
    ]
    
    init(provider: ServiceProviderType) {
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = fetchRootViewControllers()
        self.setupTabBarController()
        //self.setupNavigationController()
    }
    
    private func setupTabBarController() {
        self.selectedIndex = 0
        //TODO: tabBarItem selected color 정하기
        //TODO: tabBar 영역 컨텐츠에 따른 불투명도 표시 확인하기
        //self.tabBar.isTranslucent = true
        //self.tabBar.backgroundColor = .tertiarySystemBackground
        //self.tabBar.items?.forEach { $0.image?.withTintColor(.white) }
    }
    
    private func setupNavigationController() {
        // 비활성화, Large Title의 left margin을 추가
        let style = NSMutableParagraphStyle()
        style.firstLineHeadIndent = 8
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.paragraphStyle: style]
    }
    
    private func fetchRootViewControllers() -> [UINavigationController] {
        return zip(self.rootViewControllers, self.tabBarItems)
            .map { rootViewController, tabbarItem -> UINavigationController in
                rootViewController.view.backgroundColor = .systemBackground
                rootViewController.tabBarItem = tabbarItem
                
                return UINavigationController(rootViewController: rootViewController).then {
                    $0.navigationBar.prefersLargeTitles = true
                    $0.navigationBar.topItem?.title = tabbarItem.title
                }
            }
    }
}

