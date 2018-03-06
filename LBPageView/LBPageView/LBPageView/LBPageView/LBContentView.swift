//
//  LBContentView.swift
//  LBPageView
//
//  Created by liubo on 2018/3/5.
//  Copyright © 2018年 liubo. All rights reserved.
//

import UIKit

private let LBContentViewCellID = "LBContentViewCellID"


protocol LBContentViewDelegate : class {
    func contentView(_ contentView : LBContentView, targetIndex : Int)
    func contentView(_ contentView : LBContentView, targetIndex : Int, progress : CGFloat)
}

class LBContentView: UIView {
    
    weak var delegate : LBContentViewDelegate?
    
    fileprivate var childVcs : [UIViewController]
    fileprivate var parentVc : UIViewController
    
    fileprivate var startOffsetX : CGFloat = 0
    fileprivate lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: LBContentViewCellID)
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.scrollsToTop = false
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    init(frame: CGRect, childVcs : [UIViewController], parentVc : UIViewController) {
        self.childVcs = childVcs
        self.parentVc = parentVc
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension LBContentView {
    fileprivate func setupUI() {
        // 将所有子控制器添加到父控制器中
        for childVc in childVcs {
            parentVc.addChildViewController(childVc)
        }
        
        // 添加UICollection用于展示内容
        addSubview(collectionView)
    }
}


extension LBContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LBContentViewCellID, for: indexPath)
        
        for subView in cell.contentView.subviews {
            subView.removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
}


// UICollectionView的delegate
extension LBContentView : UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        contentEndScroll()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            contentEndScroll()
        }
    }
    
    private func contentEndScroll() {
        // 获取滚动到的位置
        let currentIndex = Int(collectionView.contentOffset.x / collectionView.bounds.width)
        
        // 通知titleView进行调整
        delegate?.contentView(self, targetIndex: currentIndex)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 判断和开始时的偏移量是否一致
        guard startOffsetX != scrollView.contentOffset.x else {
            return
        }
        
        // 定义targetIndex/progress
        var targetIndex = 0
        var progress : CGFloat = 0.0
        
        // 给targetIndex/progress赋值
        let currentIndex = Int(startOffsetX / scrollView.bounds.width)
        if startOffsetX < scrollView.contentOffset.x {
            // 左滑动
            targetIndex = currentIndex + 1
            if targetIndex > childVcs.count - 1 {
                targetIndex = childVcs.count - 1
            }
            
            progress = (scrollView.contentOffset.x - startOffsetX) / scrollView.bounds.width
        } else {
            // 右滑动
            targetIndex = currentIndex - 1
            if targetIndex < 0 {
                targetIndex = 0
            }
            
            progress = (startOffsetX - scrollView.contentOffset.x) / scrollView.bounds.width
        }
        
        // 通知代理
        delegate?.contentView(self, targetIndex: targetIndex, progress: progress)
    }
}


// LBTitleViewDelegate
extension LBContentView : LBTitleViewDelegate {
    func titleView(_ titleView: LBTitleView, targetIndex: Int) {
        let indexPath = IndexPath(item: targetIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
    }
}

