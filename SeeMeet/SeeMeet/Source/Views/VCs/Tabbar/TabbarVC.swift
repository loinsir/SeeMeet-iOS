//
//  TabbarVC.swift
//  SeeMeet
//
//  Created by 박익범 on 2022/01/08.
//

import UIKit

class TabbarVC: UITabBarController {
    
    static let identifier: String = "TabbarVC"
    public var tabs: [UIViewController] = []
    private var comeBackIndex = 0
    private var isNotch = UIScreen.hasNotch

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedViewController = tabs[comeBackIndex]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTabbar()
    }
    
//    탭바 선택시 화면전환 구현
//    internal override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem){
//        if item == tabs[0] {
//            comeBackIndex = 0
//        }
//        else if item == tabs[1] {
//            comeBackIndex = 0
//        }
//        else if item == tabs[2] {
//            comeBackIndex = 0
//        }
//    }
        
    private func configTabbar(){
        let customTabbar = tabBar
        customTabbar.tintColor = .black
        customTabbar.unselectedItemTintColor = .black
        customTabbar.backgroundColor = UIColor.white
        
        

        let homeStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let homeVC = homeStoryboard.instantiateViewController(identifier: "HomeVC")
        let homeTab = UINavigationController(rootViewController: homeVC)
        homeTab.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "home_ic"), selectedImage: UIImage(named: "home_ic_clicked"))

        let sendEventStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let sendEventVC = sendEventStoryboard.instantiateViewController(identifier: "HomeVC")
        let sendEventTab = UINavigationController(rootViewController: sendEventVC)
        sendEventTab.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "btn_send-message"), selectedImage: UIImage(named: "btn_send-message"))
        
        let calendarStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let calendarVC = calendarStoryboard.instantiateViewController(identifier: "HomeVC")
        let calendarTab = UINavigationController(rootViewController: calendarVC)
        calendarTab.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "calendar_ic"), selectedImage: UIImage(named: "calendar_ic_clicked"))
        
        if isNotch {
            homeTab.tabBarItem.imageInsets = UIEdgeInsets(top: -5, left: 0, bottom: 0, right: 0)
            sendEventTab.tabBarItem.imageInsets = UIEdgeInsets(top: -15, left: 0, bottom: 0, right: 0)
            calendarTab.tabBarItem.imageInsets = UIEdgeInsets(top: -5, left: 0, bottom: 0, right: 0)
        }
        else {
            homeTab.tabBarItem.imageInsets = UIEdgeInsets(top: -25, left: 0, bottom: 0, right: 0)
            sendEventTab.tabBarItem.imageInsets = UIEdgeInsets(top: -40, left: 0, bottom: 0, right: 0)
            calendarTab.tabBarItem.imageInsets = UIEdgeInsets(top: -25, left: 0, bottom: 0, right: 0)
        }
        
        tabs = [homeTab, sendEventTab, calendarTab]
        
        setViewControllers(tabs, animated: true)
        selectedViewController = homeTab
    }
    
    override func viewDidLayoutSubviews() {
        let customTabbar = tabBar
        let tabbarY = view.getDeviceHeight()
        let tabbarX = view.getDeviceWidth()
        var tabbarHeight = 88
        if isNotch == false {tabbarHeight = 78}

        let frame = CGRect(x: 0,
                              y: tabbarY - tabbarHeight,
                              width: tabbarX,
                              height: tabbarHeight)
        customTabbar.frame = frame
    }

}
