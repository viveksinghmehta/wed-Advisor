//
//  TabBarController.swift
//  WedAdvisor
//
//  Created by WishACloud on 20/06/21.
//  Copyright © 2021 Vishal Pandey. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBar()
    }
    
    fileprivate func setUpTabBar() {
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let home = Storyboard.instantiateViewController(identifier: "NewHomeVC") as? NewHomeVC else {
            print("not working")
            return }
        home.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "Home"), tag: 0)
        home.tabBarItem.imageInsets = UIEdgeInsets.init(top: 20, left: 20, bottom: 20, right: 20)
        guard let vendor = Storyboard.instantiateViewController(identifier: "AllVendorsController") as? AllVendorsController else {
            print("not working")
            return }
        vendor.tabBarItem = UITabBarItem(title: "Vendor", image: UIImage(named: "Vendor"), tag: 1)
        vendor.tabBarItem.imageInsets = UIEdgeInsets.init(top: 20, left: 20, bottom: 20, right: 20)
        guard let photos = Storyboard.instantiateViewController(identifier: "GallaryController") as? GallaryController else {
            print("not working")
            return }
        photos.tabBarItem = UITabBarItem(title: "Photos", image: UIImage(named: "Wedding"), tag: 2)
        photos.tabBarItem.imageInsets = UIEdgeInsets.init(top: 20, left: 20, bottom: 20, right: 20)
        guard let wedding = Storyboard.instantiateViewController(identifier: "WeddingController") as? WeddingController else {
            print("not working")
            return }
        wedding.tabBarItem = UITabBarItem(title: "Wedding", image: UIImage(named: "Home"), tag: 3)
        wedding.tabBarItem.imageInsets = UIEdgeInsets.init(top: 20, left: 20, bottom: 20, right: 20)
        guard let blogs = Storyboard.instantiateViewController(identifier: "BlogListController") as? BlogListController else {
            print("not working")
            return }
        blogs.tabBarItem = UITabBarItem(title: "Blog", image: UIImage(named: "Blogs"), tag: 4)
        blogs.tabBarItem.imageInsets = UIEdgeInsets.init(top: 20, left: 20, bottom: 20, right: 20)
        let controllers = [home, vendor, photos, wedding, blogs]
        self.viewControllers = controllers
        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = .white
        self.tabBar.barTintColor = UIColor(named: "AppLightOrangeColor")
    }
    

}
