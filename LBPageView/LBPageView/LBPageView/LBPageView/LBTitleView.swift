//
//  LBTitleView.swift
//  LBPageView
//
//  Created by yunmei on 2018/2/10.
//  Copyright © 2018年 liubo. All rights reserved.
//

import UIKit

protocol LBTitleViewDelegate : class {
    func titleView(_ titleView : LBTitleView, targetIndex : Int)
}

class LBTitleView: UIView {
    
    weak var delegate : LBTitleViewDelegate?
    
    fileprivate var titles : [String]
    fileprivate var style : LBTitleStyle
    
    fileprivate lazy var currentIndex : Int = 0
    
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView(frame: self.bounds)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        return scrollView
    }()
    
    init(frame: CGRect, titles : [String], style : LBTitleStyle) {
        self.titles = titles
        self.style = style
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension LBTitleView {
    fileprivate func setupUI() {
        // 将UIScrollVIew添加到view中
        addSubview(scrollView)
        
        // 将titleLabel添加到UIScrollView中
        setupTitleLabels()
        
        // 设置titleLabel的frame
        setupTitleLabelsFrame()
    }
    
    private func setupTitleLabels() {
        for (i, title) in titles.enumerated() {
            let titleLabel = UILabel()
            titleLabel.text = title
            titleLabel.font = UIFont.systemFont(ofSize: style.fontSize)
            titleLabel.tag = i
            titleLabel.textAlignment = .center
            titleLabel.textColor = i == 0 ? style.selectColor : style.normalColor
            
            scrollView.addSubview(titleLabel)
            titleLabels.append(titleLabel)
            
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(_:)))
            titleLabel.addGestureRecognizer(tapGes)
            titleLabel.isUserInteractionEnabled = true
        }
    }
    
    private func setupTitleLabelsFrame() {
        let count = titles.count
        
        for (i, label) in titleLabels.enumerated() {
            var w : CGFloat = 0
            let h : CGFloat = bounds.height
            var x : CGFloat = 0
            let y : CGFloat = 0
            
            if style.isScrollEnable { // 可以滚动
                w = (titles[i] as NSString).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: 0), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : label.font], context: nil).width
                if i == 0 {
                    x = style.itemMargin * 0.5
                } else {
                    let preLabel = titleLabels[i - 1]
                    x = preLabel.frame.maxX + style.itemMargin
                }
            } else { // 不能滚动
                w = bounds.width / CGFloat(count)
                x = w * CGFloat(i)
            }
            
            label.frame = CGRect(x: x, y: y, width: w, height: h)
        }
        
        scrollView.contentSize = style.isScrollEnable ? CGSize(width: titleLabels.last!.frame.maxX + style.itemMargin * 0.5, height: 0) : CGSize.zero
    }
}


// 监听事件
extension LBTitleView {
    @objc fileprivate func titleLabelClick(_ tapGes : UITapGestureRecognizer) {
        // 取出用户点击的View
        let targetLabel = tapGes.view as! UILabel
        
        // 调整title
        adjustTitleLabel(targetIndex: targetLabel.tag)
        
        // 通知代理
        delegate?.titleView(self, targetIndex: currentIndex)
    }
    
    fileprivate func adjustTitleLabel(targetIndex : Int) {
        
        if targetIndex == currentIndex { return }
        
        // 取出Label
        let targetLabel = titleLabels[targetIndex]
        let sourceLabel = titleLabels[currentIndex]
        
        // 切换文字的颜色
        targetLabel.textColor = style.selectColor
        sourceLabel.textColor = style.normalColor
        
        // 记录下标值
        currentIndex = targetIndex
        
        // 调整位置
        if style.isScrollEnable {
            var offsetX = targetLabel.center.x - scrollView.bounds.width * 0.5
            if offsetX < 0 {
                offsetX = 0
            }
            if offsetX > (scrollView.contentSize.width - scrollView.bounds.width) {
                offsetX = scrollView.contentSize.width - scrollView.bounds.width
            }
            scrollView.setContentOffset(CGPoint(x: offsetX, y : 0), animated: true)
        }
    }
}


// LBContentViewDelegate
extension LBTitleView : LBContentViewDelegate {
    func contentView(_ contentView: LBContentView, targetIndex: Int) {
        adjustTitleLabel(targetIndex: targetIndex)
    }
    
    func contentView(_ contentView: LBContentView, targetIndex: Int, progress: CGFloat) {
        // 取出Label
        let targetLabel = titleLabels[targetIndex]
        let sourceLabel = titleLabels[currentIndex]
        
        // 颜色渐变
        let deltaRGB = UIColor.getRGBDelta(style.selectColor, style.normalColor)
        let selectRGB = style.selectColor.getRGB()
        let normalRGB = style.normalColor.getRGB()
        targetLabel.textColor = UIColor(r: normalRGB.0 + deltaRGB.0 * progress, g: normalRGB.1 + deltaRGB.1 * progress, b: normalRGB.2 + deltaRGB.2 * progress)
        sourceLabel.textColor = UIColor(r: selectRGB.0 - deltaRGB.0 * progress, g: selectRGB.1 - deltaRGB.1 * progress, b: selectRGB.2 - deltaRGB.2 * progress)
    }
    
}

