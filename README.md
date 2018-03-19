# LBTV
直播


##### 1、直播项目第一天<br>
1、用Storyboard来创建模块页面<br>
2、在extension中给系统的类扩充构造函数,只能扩充`便利构造函数`,设置默认值alpha:CGFloat = 1.0，系统就会出现两个方法供我们选择<br>
```
convenience init(r:CGFloat,g:CGFloat,b:CGFloat,alpha:CGFloat = 1.0) {
    self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
}
```
3、类方法：随机颜色<br>
```
class func randomColor() -> UIColor {
    return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
}
```

