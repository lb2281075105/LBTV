//
//  LBHomeController.swift
//  LBTV
//
//  Created by liubo on 2017/11/5.
//  Copyright © 2017年 liubo. All rights reserved.
//

import UIKit

class LBHomeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white;
        addUI()
    }
}

extension LBHomeController{
    fileprivate func addUI(){
        // 左侧logoItem
        let logoImage = UIImage(named: "center_icon_follow_zhibo")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: logoImage, style: .plain, target: nil, action: nil)
        
        // 设置右侧收藏的item
        let collectImage = UIImage(named: "search_btn_follow")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: collectImage, style: .plain, target: self, action: #selector(followItemClick))
        // 搜索框
        let searchFrame = CGRect(x: 0, y: 0, width: 200, height: 32)
        let searchBar = UISearchBar(frame: searchFrame)
        searchBar.placeholder = "主播昵称/房间号/链接"
        navigationItem.titleView = searchBar
        searchBar.searchBarStyle = .minimal
        let searchFiled = searchBar.value(forKey: "_searchField") as? UITextField
        searchFiled?.textColor = UIColor.white
    }
}
// 事件监听函数
extension LBHomeController {
    @objc fileprivate func followItemClick() {
        print("------")
    }
}
