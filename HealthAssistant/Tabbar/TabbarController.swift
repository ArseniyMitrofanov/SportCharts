//
//  TabbarController.swift
//  HealthAssistant
//
//  Created by Арсений on 21.02.24.
//

import Foundation
import UIKit

final class TabbarController: UITabBarController {
    
    private var customTabBarView = UIView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hidesBottomBarWhenPushed = true
        fillTabBar()
        addCustomTabBarView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setupCustomTabBarFrame()
    }
    
}

private extension TabbarController {
    
    func setupCustomTabBarFrame() {
        let height = self.view.safeAreaInsets.bottom + 60
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = height
        tabFrame.origin.y = self.view.frame.size.height - height
        self.tabBar.frame = tabFrame
        self.tabBar.setNeedsLayout()
        self.tabBar.layoutIfNeeded()
        self.tabBar.tintColor = .red
        customTabBarView.frame = tabBar.frame
    }
    
    func addCustomTabBarView() {
        self.customTabBarView.frame = tabBar.frame
        self.customTabBarView.backgroundColor = .white
        self.customTabBarView.layer.masksToBounds = false
        self.view.addSubview(customTabBarView)
        self.view.bringSubviewToFront(self.tabBar)
               
    }
    
    func fillTabBar(){
        let weightViewController = WeightModuleBuilder.setupModule()
        let settingsViewController = SettingsModuleBuilder.setupModule()
        
        weightViewController.tabBarItem = UITabBarItem(title: "Weight",
                                                       image: UIImage(systemName: "chart.line.downtrend.xyaxis"),
                                                       tag: 0)
        settingsViewController.tabBarItem = UITabBarItem(title: "Settings",
                                                         image: UIImage(systemName: "gearshape"),
                                                         tag: 1)
     
        
        self.viewControllers = [weightViewController, settingsViewController]
        self.selectedIndex = 0
    }
}


