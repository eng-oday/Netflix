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
        
        let homeNavigation                      = UINavigationController(rootViewController: HomeVc())
        let searchNavigation                    = UINavigationController(rootViewController: SearchVC())
        let comingsoonNavigation                = UINavigationController(rootViewController: ComingSoonVc())
        let downloadsNavigation                 = UINavigationController(rootViewController: DownloadsVC())
        
        homeNavigation.title                    = TabBar.home
        searchNavigation.title                  = TabBar.search
        comingsoonNavigation.title              = TabBar.comingSoon
        downloadsNavigation.title               = TabBar.downloads
        
        homeNavigation.tabBarItem.image         = TabBarImage.home
        searchNavigation.tabBarItem.image       = TabBarImage.search
        comingsoonNavigation.tabBarItem.image   = TabBarImage.comingsoon
        downloadsNavigation.tabBarItem.image    = TabBarImage.downloads
        
        tabBar.tintColor    = .label
        
        setViewControllers([homeNavigation,searchNavigation,comingsoonNavigation,downloadsNavigation], animated: true)
        
        
    }
    
    
    
}
