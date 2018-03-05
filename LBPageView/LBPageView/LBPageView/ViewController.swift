//
//  ViewController.swift
//  LBPageView
//
//  Created by yunmei on 2018/2/6.
//  Copyright © 2018年 liubo. All rights reserved.
//


/*
 self.不能省略的情况
 1、在方法中和其他的标识符有歧义(重名)
 2、在闭包(block)中self.也不能省略
 */

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let titles = ["游戏", "娱乐", "趣玩", "美女", "颜值"]
        let titles = ["游戏", "娱乐娱乐娱乐", "趣玩", "美女女", "颜值颜值", "趣玩", "美女女", "颜值颜值"]
        let style = LBTitleStyle()

        // 子控制器
        var childVcs = [UIViewController]()
        for _ in 0..<titles.count {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.randomColor()
            childVcs.append(vc)
        }
        
        let pageFrame = CGRect(x: 0, y: 64, width: view.bounds.width, height: view.bounds.height - 64)
        
        let pageView = LBPageView(frame: pageFrame, titles: titles, childVcs: childVcs, parentVc: self, style : style)
        view.addSubview(pageView)
    }
        
}

