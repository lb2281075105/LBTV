//
//  LBPageView.swift
//  LBPageView
//
//  Created by yunmei on 2018/2/10.
//  Copyright © 2018年 liubo. All rights reserved.
//

import UIKit

class LBPageView: UIView {

    fileprivate var titles : [String]
    fileprivate var childVcs : [UIViewController]
    fileprivate var parentVc : UIViewController
    fileprivate var style : LBTitleStyle
    fileprivate var titleView : LBTitleView!
    
    init(frame: CGRect, titles : [String], childVcs : [UIViewController], parentVc : UIViewController, style : LBTitleStyle) {
        self.titles = titles
        self.childVcs = childVcs
        self.parentVc = parentVc
        self.style = style
        
        super.init(frame: frame)
        
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension LBPageView {
    fileprivate func setUpUI() {
        setUpTitleView()
        setUpContentView()
    }
    
    private func setUpTitleView() {
        let titleFrame = CGRect(x: 0, y: 0, width: bounds.width, height: style.titleHeight)
        titleView = LBTitleView(frame: titleFrame, titles: titles, style : style)
        addSubview(titleView)
        titleView.backgroundColor = UIColor.randomColor()
    }
    
    private func setUpContentView() {

        let contentFrame = CGRect(x: 0, y: style.titleHeight, width: bounds.width, height: bounds.height - style.titleHeight)
        let contentView = LBContentView(frame: contentFrame, childVcs: childVcs, parentVc: parentVc)
        addSubview(contentView)
        contentView.backgroundColor = UIColor.randomColor()
        
        // contentView成为titleView代理
        titleView.delegate = contentView
    }
}
