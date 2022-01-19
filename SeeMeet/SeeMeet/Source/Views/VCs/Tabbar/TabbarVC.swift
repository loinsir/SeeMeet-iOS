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
        self.delegate = self
        configTabbar()
    }
//
//    internal override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem){
//        if item.image == UIImage(named: "home_ic")  {
//            print("tab1")
//            comeBackIndex = 0
//        }
//        else if item.image == UIImage(named: "btn_send-message") {
//            print("tab2")
//            if UserDefaults.standard.bool(forKey: "isLogin") == false {
//                self.makeAlert(title: "꺄ㅏ아아아ㅏㄱ", message: "꺄아아아ㅏㄱ", okAction: nil, completion: nil)
//            }
//            comeBackIndex = 1
//        }
//        else if item.image == UIImage(named: "calendar_ic"){
//            print("tab3")
//            comeBackIndex = 2
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

        let sendEventStoryboard = UIStoryboard(name: "RequestPlansContents", bundle: nil)
        let sendEventVC = sendEventStoryboard.instantiateViewController(identifier: "RequestPlansContentsVC")
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
//로그인 안됬을때 홈 막기
extension TabbarVC: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
            if tabBarController.tabBar.selectedItem?.image == UIImage(named: "btn_send-message"){
                if UserDefaults.standard.bool(forKey: "isLogin") == false{
                    let customAlert = SMPopUpVC(withType: .needLogin) as! SMPopUpVC
                    customAlert.modalPresentationStyle = .overFullScreen
                    self.present(customAlert, animated: false, completion: nil)
                    customAlert.pinkButtonCompletion =
                                {
                                    let loginVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                                    self.navigationController?.pushViewController(loginVC, animated: true)
                                    self.dismiss(animated: false, completion: nil)
                                }
                    return false
                }
            }
            return true
    }
}
