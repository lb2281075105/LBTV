//
//  ViewController.swift
//  LBPageView
//
//  Created by yunmei on 2018/2/6.
//  Copyright © 2018年 liubo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let titles = ["游戏", "娱乐", "趣玩", "美女", "颜值"]
        
        var childVcs = [UIViewController]()
        for _ in 0..<titles.count {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.randomColor()
            childVcs.append(vc)
        }
        
        let pageFrame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        
        let pageView = LBPageView(frame: pageFrame, titles: titles, childVcs: childVcs, parentVc: self, style : style)
        view.addSubview(pageView)
    }
        
}

