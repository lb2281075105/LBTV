//
//  LBHomeType.swift
//  LBTV
//
//  Created by liubo on 2018/3/20.
//  Copyright © 2018年 liubo. All rights reserved.
//

import UIKit

class LBHomeType: NSObject {
    
    var title : String = ""
    var type : Int = 0
    
    override init() {}
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
