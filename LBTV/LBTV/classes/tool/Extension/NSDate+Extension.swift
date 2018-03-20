//
//  NSDate+Extension.swift
//  LBTV
//
//  Created by liubo on 2018/3/20.
//  Copyright © 2018年 liubo. All rights reserved.
//

import Foundation

extension Date {
    static func getCurrentTime() -> String {
        let nowDate = Date()
        let interval = Int(nowDate.timeIntervalSince1970)
        return "\(interval)"
    }
}
