//
//  PageTitleView.swift
//  Douyu-TV
//
//  Created by 刘亚勋 on 16/10/8.
//  Copyright © 2016年 刘亚勋. All rights reserved.
//  自定义页面

import UIKit



/// 代理
protocol PageTitleViewDelegate : class {
    
    func pageTitleViewDidClick(titleView : PageTitleView, selectedIndex : Int)
    
}


class PageTitleView: UIView {
    // MARK: ------ 定义属性
    weak var delegate : PageTitleViewDelegate!
    private var previousBtn : UIButton = UIButton()
    private var scrollLine : UIView = UIView()
    private var pageTitles:[String]
    private var titleButtons:[UIButton] = [UIButton]()
    private var selectColor : (CGFloat ,CGFloat ,CGFloat) = (255.0,155.0,76.0)
    
    // MARK: ------ 对外公开的方法
    func titleViewDidScroll(sourceIndex : Int ,targetIndex : Int , progress : CGFloat){
        // 滚动条开始滚动
        let btn_width : CGFloat = frame.size.width / CGFloat(pageTitles.count)
        if sourceIndex < targetIndex { //右滑
            let x = btn_width * (CGFloat(sourceIndex) + progress)
            scrollLine.frame.origin.x = x
        }else if sourceIndex > targetIndex{ // 左滑
            let x = btn_width * (CGFloat(sourceIndex) - progress)
            scrollLine.frame.origin.x = x
        }
    
        // 字体开始变颜色
        let sourceBtn = titleButtons[sourceIndex]
        let targetBtn = titleButtons[targetIndex]
        let r : CGFloat = progress * selectColor.0
        let g : CGFloat = progress * selectColor.1
        let b : CGFloat = progress * selectColor.2
        
        let targetColor = UIColor(r: 0 + r, g: g, b: b)
        let sourceColor = UIColor(r: 255.0 - r, g: 155.0 - g, b: 76.0 - b)
        
        sourceBtn.setTitleColor(sourceColor, for: .normal)
        targetBtn.setTitleColor(targetColor, for: .normal)
    
        // 记录上一个按钮
        previousBtn = targetBtn
        
    }
    
    
    // MARK: ------ 懒加载视图
    private lazy var scrollView : UIScrollView = {
        
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        
        return scrollView
        
    }()
    

    // MARK: ------ 构造函数
    init(frame: CGRect, titles:[String]) {
        pageTitles = titles
        /// 添加UI信息
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: ------ 设置UI信息
    private func setupUI(){
        // 添加滚动视图
        addSubview(scrollView)
        scrollView.frame = bounds
        // 添加所有的子按钮
        addSubButton()
        // 添加底部条
        addBottomLine()
    }
    
    /// 添加子按钮
    private func addSubButton(){
        let btn_width : CGFloat = frame.size.width / CGFloat(pageTitles.count)
        let btn_height : CGFloat = frame.size.height
        let btn_y : CGFloat = 0
    
        // 遍历所有的标题
        for (index, title) in pageTitles.enumerated(){
            let btn_x = CGFloat(index) * btn_width
            let btn = UIButton(frame: CGRect(x: btn_x, y: btn_y, width: btn_width, height: btn_height))
            btn.setTitle(title, for: .normal)
            btn.setTitleColor(UIColor.black, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
            btn.addTarget(self, action: #selector(self.titlebtnClick(button:)), for: .touchUpInside)
            if index == 0 {
                previousBtn = btn
                btn.setTitleColor(UIColor.orange, for: .normal)
            }
            scrollView.addSubview(btn)
            titleButtons.append(btn)
        }
        
    }
    
    // MARK: ------ 按钮的点击事件
     @objc private func titlebtnClick(button : UIButton){
        
        // 1.将上一个按钮的文字颜色变成黑色
        previousBtn.setTitleColor(UIColor.black, for: .normal)
        // 2.点击的按钮颜色变成橘色
        button.setTitleColor(UIColor.orange, for: .normal)

        previousBtn = button
        
        // 3.将底部条移动到点击到按钮下方
        let index = pageTitles.index(of: button.currentTitle!)!
        UIView.animate(withDuration: 0.2) { 
            self.scrollLine.frame.origin.x = CGFloat(index) * button.frame.width
        }
        
        /// 4.通知代理
        delegate.pageTitleViewDidClick(titleView: self, selectedIndex: index)
        
    
    }
    
    
    
    /// 添加底部条
    private func addBottomLine(){
        
        //1.添加底部线
        let bottomLine = UIView.init(frame: CGRect(x: 0, y: bounds.height - 0.5, width: bounds.width, height: 0.5))
        bottomLine.backgroundColor = UIColor.lightGray
        addSubview(bottomLine)
        
        //2.添加底部滚动条
        let scrollLine = UIView.init(frame: CGRect(x: 0, y: bounds.height - 1.5, width: bounds.width / CGFloat(pageTitles.count), height: 2))
        scrollLine.backgroundColor = UIColor.orange
        addSubview(scrollLine)        
        self.scrollLine = scrollLine
        
    }

}
