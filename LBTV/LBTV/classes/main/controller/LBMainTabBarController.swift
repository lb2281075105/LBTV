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

        addChildVc("LBHome")
        addChildVc("LBRank")
        addChildVc("LBDiscover")
        addChildVc("LBProfile")
    }
    
    fileprivate func addChildVc(_ storyName : String) {
        // 通过storyboard获取控制器
        let childVc = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        let nav = UINavigationController.init(rootViewController: childVc)
        // 将childVc作为子控制器
        addChildViewController(nav)
    }
}
