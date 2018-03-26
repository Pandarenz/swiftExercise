//
//  LZPageContainer.swift
//  LZPageControl
//
//  Created by JiWuChao on 2018/3/19.
//  Copyright © 2018年 JiWuChao. All rights reserved.
//

import UIKit

protocol LZPageContainerDelegate {
    //目前显示的是第几个
    func pageContainer(pageContainer:LZPageContainer, didShowViewAtIndex index:Int)
    //从某一个fromIndex 滚动到另一个toIndex
    func pageContainer(pageContainer:LZPageContainer, scrolFromIndex fIndex:Int,toIndex tIndex:Int ,progress:CGFloat)
    func pageContainerDidStop()
}

protocol LZPageContainerDataSource {
    //container中显示几个View
    func pageContainerChildrenCount(pageContainer:LZPageContainer) -> Int
    //每个index对应的view
    func pageContainerChildren(pageContainer:LZPageContainer, viewAtIndex atIndex:Int) -> UIView
    
}

class LZPageContainer: UIView {
    
    fileprivate  lazy var scrollView : UIScrollView = {
        let scroll = UIScrollView(frame: self.bounds)
        scroll.delegate = self
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.isPagingEnabled = true
        scroll.bounces = false
        addSubview(scroll)
        return scroll
    }()
    
//    var childrens :[UIView] = [UIView]()
    var childrenCount :Int = 0
    var currentIndex :Int = 0{
        
        didSet {
            
        }
    }
    var isClickedEv :Bool = false
    
    fileprivate lazy var cache :LZPageCache = {
       let cache = LZPageCache()
        return cache
    }()
    
    fileprivate  var startOffsetX : CGFloat = 0
    
    var delegate : LZPageContainerDelegate?
    var dataSource : LZPageContainerDataSource?
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI()  {
        scrollView.backgroundColor = UIColor.red
        scrollView.setNeedsLayout()
    }
    
   fileprivate func updateContenSize() {
        guard childrenCount == 0 else {
            return
        }
    scrollView.contentSize = CGSize(width: scrollView.bounds.size.width * CGFloat(childrenCount), height: scrollView.bounds.size.height)
        
    }
   
    fileprivate func addChildren(childrenView children:UIView, atIndex aIndex:Int ,superView sView:UIView)  {
        let childrenView = cache.getCacheObj(atIndex: aIndex)
        if childrenView != children {
             childrenView?.removeFromSuperview()
            children.frame = CGRect(x: sView.bounds.size.width * CGFloat(aIndex), y: 0, width: sView.bounds.size.width, height: sView.bounds.size.height)
            sView.addSubview(children)
            cache.cacheObj(cacheObj: children, atIndex: aIndex)
        }
    }
   
    
}


//对外方法
extension LZPageContainer {
    
    // 从第几个滚动到第几个
    func scrollToIndexToIndex(fromIndex fIndex:Int, toIndex tIndex:Int, withAnimated animated:Bool)  {
        isClickedEv = true
        currentIndex = tIndex
        if !cache.hasCache(subIndex: tIndex) {
            let view = dataSource?.pageContainerChildren(pageContainer: self, viewAtIndex: tIndex)
            if view != nil{
                addChildren(childrenView: view!, atIndex: tIndex, superView: scrollView)

            } else {
                fatalError("dataSource?.pageContainerChildren(pageContainer: self, viewAtIndex: tIndex) return nil ")
            }
        } else {
            let view = cache.getCacheObj(atIndex: tIndex)
            view?.frame.size.width = scrollView.frame.width
            view?.frame.size.height = scrollView.frame.height
        }
        scrollView.setContentOffset(CGPoint(x: scrollView.bounds.width * CGFloat(tIndex), y: 0), animated: animated)
    }
    // 刷新列表
    func reloadData() {
        childrenCount = (dataSource?.pageContainerChildrenCount(pageContainer: self))!
        updateContenSize()
        if childrenCount > 0 {
            var view = cache.getCacheObj(atIndex: 0 )
            if (view == nil) {
                view = dataSource?.pageContainerChildren(pageContainer: self, viewAtIndex: 0)
                if view != nil {
                    addChildren(childrenView: view!, atIndex: 0, superView: scrollView)
                    cache.cacheObj(cacheObj: view!, atIndex: 0)
                }
            }
        }
    }
 
    
}

extension LZPageContainer:UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isClickedEv = false
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.updateContentIndex(scroller: scrollView)
    }
    
    func updateContentIndex(scroller scrollerView:UIScrollView)  {
        
        if isClickedEv {
            return
        }
        
        // 2.定义获取需要的数据
        var progress : CGFloat = 0.0
        var fromIndex : Int = 0
        var toIndex : Int = 0
        
        // 3.判断是向左滑还是向右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX { //左滑
            // 1.计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            
            // 2.计算sourceIndex
            fromIndex = Int(currentOffsetX / scrollViewW)
            
            // 3.计算targetIndex
            toIndex = fromIndex + 1
            if toIndex >= childrenCount {
                toIndex = childrenCount - 1
            }
            
            // 4.如果完全划出去
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                toIndex = fromIndex
            }
        } else { // 右滑
            // 1.计算progress
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            
            // 2.计算targetIndex
            toIndex = Int(currentOffsetX / scrollViewW)
            
            // 3.计算sourceIndex
            fromIndex = toIndex + 1
            if fromIndex >= childrenCount {
                fromIndex = childrenCount - 1
            }
        }
        currentIndex = toIndex
        delegate?.pageContainer(pageContainer: self, scrolFromIndex: fromIndex, toIndex: toIndex, progress: progress)
 
        if toIndex >= 0 && toIndex < childrenCount {
            var toView = cache.getCacheObj(atIndex: toIndex)
            if(toView == nil) {
                toView = dataSource?.pageContainerChildren(pageContainer: self, viewAtIndex: toIndex)
                if (toView != nil) {
                    addChildren(childrenView: toView!, atIndex: toIndex, superView: scrollView)
                }
            }
        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegate?.pageContainerDidStop()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            delegate?.pageContainerDidStop()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.frame = self.bounds
        scrollView.contentSize = CGSize(width: scrollView.bounds.width * CGFloat(childrenCount), height: self.bounds.height)
        for (index,view) in cache.getAll() {
            view.frame = CGRect(x: scrollView.bounds.size.width * CGFloat(index), y: 0, width: scrollView.bounds.size.width, height: scrollView.bounds.size.height)
        }
         scrollView.setContentOffset(CGPoint(x: scrollView.bounds.width * CGFloat(currentIndex), y: 0), animated: false)
        
    }
}

