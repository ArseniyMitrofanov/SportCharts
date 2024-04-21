//
//  TabbarController.swift
//  HealthAssistant
//
//  Created by Арсений on 21.02.24.
//

import Foundation
import UIKit

final class TabbarController: UITabBarController {
    
    private var whiteBackgroudView = UIView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hidesBottomBarWhenPushed = true
        self.fillTabBar()
        self.setupBackgroudView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setupCustomTabBar()
    }
    
}

private extension TabbarController {
    
    func setupCustomTabBar() {
        let height = self.view.safeAreaInsets.bottom + 65
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = height
        tabFrame.origin.y = self.view.frame.size.height - height
        self.tabBar.frame = tabFrame
        self.tabBar.setNeedsLayout()
        self.tabBar.layoutIfNeeded()
        self.tabBar.tintColor = UIColor.init(named: "Backgroud")
        self.tabBar.unselectedItemTintColor = UIColor(named: "UnselectedWhite")
        self.whiteBackgroudView.frame = tabBar.frame
    }
    
    func setupBackgroudView() {
        self.whiteBackgroudView.backgroundColor = .white
        self.whiteBackgroudView.layer.masksToBounds = false
        self.whiteBackgroudView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        self.whiteBackgroudView.layer.cornerRadius = 20
        self.view.addSubview(self.whiteBackgroudView)
        self.view.bringSubviewToFront(self.tabBar)
        
    }
    
    func fillTabBar() {
        let weightViewController = WeightModuleBuilder.setupModule()
        let nutritionViewController = AdviceModuleBuilder.setupModule(type: .nutrition)
        let exerciseViewController = AdviceModuleBuilder.setupModule(type: .exercise)
        let settingsViewController = SettingsModuleBuilder.setupModule()
        
        
        weightViewController.tabBarItem = UITabBarItem(title: "",
                                                       image: UIImage(systemName: "chart.xyaxis.line"),
                                                       tag: 0)
        nutritionViewController.tabBarItem = UITabBarItem(title: "",
                                                       image: UIImage(systemName: "fork.knife"),
                                                       tag: 1)
        
        exerciseViewController.tabBarItem = UITabBarItem(title: "",
                                                       image: UIImage(systemName: "dumbbell.fill"),
                                                       tag: 2)
        
        settingsViewController.tabBarItem = UITabBarItem(title: "",
                                                         image: UIImage(systemName: "gearshape.fill"),
                                                         tag: 3)
        
        self.viewControllers = [weightViewController, nutritionViewController, exerciseViewController, settingsViewController]
        self.selectedIndex = 0
    }
}


