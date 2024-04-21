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
        let adviseViewController = WeightModuleBuilder.setupModule()
        let settingsViewController = SettingsModuleBuilder.setupModule()
        
        weightViewController.tabBarItem = UITabBarItem(title: "",
                                                       image: UIImage(systemName: "chart.line.downtrend.xyaxis.circle.fill"),
                                                       tag: 0)
        //потом его напишу - пока так чисто глянуть иконки
        adviseViewController.tabBarItem = UITabBarItem(title: "",
                                                       image: UIImage(systemName: "book.fill"),
                                                       tag: 1)
        
        settingsViewController.tabBarItem = UITabBarItem(title: "",
                                                         image: UIImage(systemName: "gearshape.fill"),
                                                         tag: 2)
        
        self.viewControllers = [weightViewController, adviseViewController, settingsViewController]
        self.selectedIndex = 0
    }
}


