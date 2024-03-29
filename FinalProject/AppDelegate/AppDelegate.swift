//
//  AppDelegate.swift
//  FinalProject
//
//  Created by Bien Le Q. on 8/26/19.
//  Copyright © 2019 Asiantech. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        configTabbar()

        return true
    }

    func configTabbar() {

        let home = HomeViewController()
        let homeNaviVC = UINavigationController(rootViewController: home)
        homeNaviVC.tabBarItem = UITabBarItem(title: "HOME", image: #imageLiteral(resourceName: "ic-home"), selectedImage: #imageLiteral(resourceName: "ic-home-filled"))

        let search = SearchViewController()
        let searchNaviVC = UINavigationController(rootViewController: search)
        searchNaviVC.tabBarItem = UITabBarItem(title: "SEARCH", image: #imageLiteral(resourceName: "ic-search"), selectedImage: #imageLiteral(resourceName: "ic-search-filled"))

        let favorite = FavoriteViewController()
        let favoriteNaviVC = UINavigationController(rootViewController: favorite)
        favoriteNaviVC.tabBarItem = UITabBarItem(title: "Favorite", image: #imageLiteral(resourceName: "ic-heart"), selectedImage: #imageLiteral(resourceName: "ic-heart-filled"))

        let viewControllers = [homeNaviVC, searchNaviVC, favoriteNaviVC]
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = viewControllers
        tabBarController.tabBar.tintColor = .red
        window?.rootViewController = tabBarController
    }
}
