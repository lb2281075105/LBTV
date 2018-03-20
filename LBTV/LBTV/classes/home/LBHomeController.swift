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
        addContentView()
    }
}

extension LBHomeController{
    fileprivate func addUI(){
        // 左侧logoItem
        let logoImage = UIImage(named: "center_icon_follow_zhibo")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
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
    func addContentView(){
        // 加载数据
        let homeTypes = loadTypesData()
        
        let style = LBTitleStyle()
        style.isScrollEnable = true
        let pageFrame = CGRect(x: 0, y: LBNavigationBarH + LBStatusBarH, width: LBScreenW, height: LBScreenH - LBNavigationBarH - LBStatusBarH - 44)

        let titles = homeTypes.map({ $0.title })
        var childVcs = [UIViewController]()
//        for type in homeTypes {
//            let anchorVc = AnchorViewController()
//            anchorVc.homeType = type
//            childVcs.append(anchorVc)
//        }
        let pageView = LBPageView(frame: pageFrame, titles: titles, style: style, childVcs: childVcs, parentVc: self)
        view.addSubview(pageView)
        
    }
    fileprivate func loadTypesData() -> [LBHomeType] {
        let path = Bundle.main.path(forResource: "types.plist", ofType: nil)!
        let dataArray = NSArray(contentsOfFile: path) as! [[String : Any]]
        var modelArray = [LBHomeType]()
        for dict in dataArray {
            modelArray.append(LBHomeType(dict: dict))
        }
        return modelArray
    }
}
// 事件监听函数
extension LBHomeController {
    @objc fileprivate func followItemClick() {
        print("------")
    }
}

