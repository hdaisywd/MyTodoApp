//
//  MainTabBarController.swift
//  MyTodoApp
//
//  Created by Daisy Hong on 2023/08/23.

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // tab bar 아이콘 설정 1
        let firstVC = UINavigationController(rootViewController: HomeVC())
        firstVC.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "house")?.withTintColor(.systemTeal, renderingMode: .alwaysOriginal), tag: 0)
        // tab bar 아이콘 설정 2
        let secondVC = UINavigationController(rootViewController: TodoVC())
        secondVC.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "list.bullet")?.withTintColor(.systemTeal, renderingMode: .alwaysOriginal), tag: 1)
        // tab bar 아이콘 설정 3
        let thirdVC = UINavigationController(rootViewController: StarredListVC())
        thirdVC.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "star")?.withTintColor(.systemTeal, renderingMode: .alwaysOriginal), tag: 2)
        // tab bar 아이콘 설정 4
        let fourthVC = UINavigationController(rootViewController: SettingsVC())
        fourthVC.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "gearshape")?.withTintColor(.systemTeal, renderingMode: .alwaysOriginal), tag: 3)

        UITabBar.clearShadow()
        tabBar.layer.applyShadow(color: .gray, alpha: 0.3, x: 0, y: 0, blur: 12)
        viewControllers = [firstVC, secondVC, thirdVC, fourthVC]
    }
}
