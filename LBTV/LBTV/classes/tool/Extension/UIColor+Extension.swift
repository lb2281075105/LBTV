//
//  UIColor+Extension.swift
//  LBTV
//
//  Created by yunmei on 2018/1/30.
//  Copyright © 2018年 liubo. All rights reserved.
//

import UIKit

extension UIColor{
    // 在extension中给系统的类扩充构造函数,只能扩充`便利构造函数`,设置默认值alpha:CGFloat = 1.0，系统就会出现两个方法供我们选择
    convenience init(r:CGFloat,g:CGFloat,b:CGFloat,alpha:CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    convenience init?(hexStr:String,alpha:CGFloat = 1.0){
        // 0xff0000 判断字符串的长度是否符合
        guard hexStr.characters.count >= 6 else {
            return nil
        }
        var hexUpper = hexStr.uppercased()
        // 判断开头: 0x/#/##
        if hexUpper.hasPrefix("##") || hexUpper.hasPrefix("0X"){
            hexUpper = (hexUpper as NSString).substring(from: 2)
        }
        if hexUpper.hasPrefix("#") {
            hexUpper = (hexUpper as NSString).substring(from: 1)
        }

        var range = NSRange(location: 0, length: 2)
        let rHex = (hexUpper as NSString).substring(with: range)
        range.location = 2
        let gHex = (hexUpper as NSString).substring(with: range)
        range.location = 4
        let bHex = (hexUpper as NSString).substring(with: range)
        // 将十六进制转成数字 emoji表情
        var r : UInt32 = 0, g : UInt32 = 0, b : UInt32 = 0
        Scanner(string: rHex).scanHexInt32(&r)
        Scanner(string: gHex).scanHexInt32(&g)
        Scanner(string: bHex).scanHexInt32(&b)

        self.init(r : CGFloat(r), g : CGFloat(g), b : CGFloat(b))
    }
    // 类方法：随机颜色
    class func randomColor() -> UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
}
