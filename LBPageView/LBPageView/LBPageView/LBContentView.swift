//
//  LBContentView.swift
//  LBPageView
//
//  Created by yunmei on 2018/2/10.
//  Copyright © 2018年 liubo. All rights reserved.
//

import UIKit

class LBContentView: UIView {

    fileprivate var childVcs : [UIViewController]
    fileprivate var parentVc : UIViewController
    
    init(frame: CGRect, childVcs : [UIViewController], parentVc : UIViewController) {
        self.childVcs = childVcs
        self.parentVc = parentVc
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
