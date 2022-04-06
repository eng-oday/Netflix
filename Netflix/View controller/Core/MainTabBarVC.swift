//
//  MainTabBarVC.swift
//  Netflix
//
//  Created by Oday Dieg on 20/03/2022.
//

import UIKit

class MainTabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .systemBackground
        
        setTabBar()
    }
    
    func setTabBar(){
        
        
        let vc1                     =  HomeVc()
        let vc2                     = SearchVC()
        let vc3                     =  ComingSoonVc()
        let vc4                     = DownloadsVC()

        let nav1 = UINavigationController(rootViewController:vc1)
        let nav2 = UINavigationController(rootViewController:vc2)
        let nav3 = UINavigationController(rootViewController:vc3)
        let nav4 = UINavigationController(rootViewController:vc4)
        
        
        nav1.tabBarItem = UITabBarItem(title: TabBar.home, image: TabBarImage.home, tag: 1)
        nav2.tabBarItem = UITabBarItem(title: TabBar.search, image:TabBarImage.search , tag: 1)
        nav3.tabBarItem = UITabBarItem(title: TabBar.comingSoon, image:TabBarImage.comingsoon , tag: 1)
        nav4.tabBarItem = UITabBarItem(title: TabBar.downloads, image:TabBarImage.downloads , tag: 1)
        

        nav1.navigationBar.tintColor = .label
        nav2.navigationBar.tintColor = .label
        nav3.navigationBar.tintColor = .label
        nav4.navigationBar.tintColor = .label
        
   
        tabBar.tintColor    = .label
        
        setViewControllers([nav1,nav2,nav3,nav4], animated: true)

            NotificationCenter.default.addObserver(vc3, selector: #selector(vc3.ListenToNotificationCenter), name:Notification.Name(NotificationCenterNames.ComingSoonArrayOfData), object: nil)

        
    }
    
//    func ListenToNotification(){

//
//
//    }
    
    
    
}
