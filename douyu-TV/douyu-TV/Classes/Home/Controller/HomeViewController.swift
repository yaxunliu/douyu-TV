//
//  HomeViewController.swift
//  Douyu-TV
//
//  Created by 刘亚勋 on 16/10/8.
//  Copyright © 2016年 刘亚勋. All rights reserved.
//

import UIKit

let kTitleViewH : CGFloat = 44


class HomeViewController: UIViewController,PageTitleViewDelegate,PageContentViewDelegate {

    /// 标题视图
    fileprivate lazy var titleView : PageTitleView = {[weak self] in
        
        let titleRect = CGRect(x: 0, y:kStatubarH + kNavigationBarH , width: kScreenWidth , height: kTitleViewH)
        
        let titles = ["推荐","游戏","娱乐","趣玩"]
        
        let tView = PageTitleView(frame: titleRect, titles: titles)
        
        tView.delegate = self!
        
        return tView
        
    }()
    
    
    // MARK:- PageTitleViewDelegate
    func pageTitleViewDidClick(_ titleView: PageTitleView, selectedIndex: Int) {
        
        // 1.内容视图开始发生改变
        contentView.setCurrentIndex(selectedIndex)
                
    }
    
    /// 内容视图
    fileprivate lazy var contentView : PageContentView = {[weak self] in
        /// 确定frame
        let rect = CGRect(x: 0, y: kStatubarH + kNavigationBarH + kTitleViewH, width: kScreenWidth, height: kScreenHeight - kTitleViewH - kStatubarH - kNavigationBarH - kTabbarH)
        
        /// 创建子控制器
        var childVcs = [UIViewController]()
        childVcs.append(RecomendViewController())
        childVcs.append(GameViewController())
        childVcs.append(AmuseViewController())
        
        for _ in 0..<1{
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.init(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            
            childVcs.append(vc)
        }
        
        let contentV : PageContentView = PageContentView(frame: rect, childVcs: childVcs, parentVc: self!)
        
        contentV.delegate = self
        
        return contentV
    }()
    
    // MARK: - PageContentViewDelegate
    func contentViewDidScroll(_ sourceIndex: Int, targetIndex: Int, progress: CGFloat) {
        titleView.titleViewDidScroll(sourceIndex ,targetIndex : targetIndex , progress : progress)
    }
    
    // MARK: - 系统回调的函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 0.取消滚动视图缩进
        automaticallyAdjustsScrollViewInsets = false
        
        // 1.设置UI信息
        setupUI()
        

    }
    
    // 0 设置UI信息
   fileprivate func setupUI() {
        
        // 设置导航栏
        setupNavigationBar()
        
        // 添加标题视图
        view.addSubview(titleView)
    
        // 添加内容视图
        view.addSubview(contentView)
    
        
    }
    
    // 1.设置导航栏
    fileprivate func setupNavigationBar() {
        
        let size = CGSize.init(width: 40, height: 40)
        
        // logo 按钮
        let logoItem = UIBarButtonItem.init(imageName: "logo")
        navigationItem.leftBarButtonItem = logoItem
        
        // 搜索按钮
        let searchItem = UIBarButtonItem.init(imageName: "btn_search", highImageName: "btn_search_clicked", itemSize: size)
        // 扫描按钮
        let scanItem = UIBarButtonItem.init(imageName: "Image_scan", highImageName: "Image_scan_click", itemSize: size)
        // 时钟按钮
        let timeItem = UIBarButtonItem.init(imageName: "image_my_history", highImageName: "Image_my_history_click", itemSize: size)
        
        navigationItem.rightBarButtonItems = [searchItem,scanItem,timeItem]
        
        
    }


}



