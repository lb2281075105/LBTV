//
//  LBPageView.swift
//  LBTV
//
//  Created by liubo on 2018/3/20.
//  Copyright © 2018年 liubo. All rights reserved.
//

import UIKit

class LBPageView: UIView {

    fileprivate var titles : [String]!
    fileprivate var style : LBTitleStyle!
    fileprivate var childVcs : [UIViewController]!
    fileprivate weak var parentVc : UIViewController!
    
    fileprivate var titleView : LBTitleView!
    fileprivate var contentView : LBContentView!
    
    // 自定义构造函数
    init(frame: CGRect, titles : [String], style : LBTitleStyle, childVcs : [UIViewController], parentVc : UIViewController) {
        super.init(frame: frame)
        
//        assert(titles.count == childVcs.count, "标题&控制器个数不同,请检测!!!")
        self.style = style
        self.titles = titles
        self.childVcs = childVcs
        self.parentVc = parentVc
        parentVc.automaticallyAdjustsScrollViewInsets = false
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// 设置界面内容
extension LBPageView {
    fileprivate func setupUI() {
        let titleH : CGFloat = 44
        let titleFrame = CGRect(x: 0, y: 0, width: frame.width, height: titleH)
        titleView = LBTitleView(frame: titleFrame, titles: titles, style : style)
        titleView.delegate = self
        addSubview(titleView)
        
        let contentFrame = CGRect(x: 0, y: titleH, width: frame.width, height: frame.height - titleH)
        contentView = LBContentView(frame: contentFrame, childVcs: childVcs, parentViewController: parentVc)
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.delegate = self
        addSubview(contentView)
    }
}


// 设置HYContentView的代理
extension LBPageView : LBContentViewDelegate {
    func contentView(_ contentView: LBContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        titleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
    func contentViewEndScroll(_ contentView: LBContentView) {
        titleView.contentViewDidEndScroll()
    }
}


// 设置HYTitleView的代理
extension LBPageView : LBTitleViewDelegate {
    func titleView(_ titleView: LBTitleView, selectedIndex index: Int) {
        contentView.setCurrentIndex(index)
    }
}
