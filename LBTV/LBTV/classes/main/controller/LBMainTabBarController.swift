//
//  LBMainTabBarController.swift
//  LBTV
//
//  Created by liubo on 2017/11/5.
//  Copyright © 2017年 liubo. All rights reserved.
//

import UIKit

class LBMainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVc(childVc: LBHomeController(), title: "首页", imageName: "live")
        addChildVc(childVc: LBRankController(), title: "消息", imageName: "ranking")
        addChildVc(childVc: LBDiscoverController(), title: "发现", imageName: "found")
        addChildVc(childVc: LBProfileController(), title: "我", imageName: "mine")
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.cz_color(withRed: 190, green: 139, blue: 82)], for: UIControlState.selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.black], for: UIControlState.normal)
    }
    
    private func addChildVc(childVc: UIViewController, title : String, imageName : String) {
        
        // 设置子控制器的属性
        childVc.title = title
        childVc.tabBarItem.image = UIImage(named: imageName + "-n")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        childVc.tabBarItem.selectedImage = UIImage(named: imageName + "-p")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)

        // 设置导航栏控制器
        let childNav = LBNavController(rootViewController: childVc)
        
        // 添加控制器
        addChildViewController(childNav)
    }

}
