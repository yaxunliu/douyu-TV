//
//  RecomandHeaderView.swift
//  Douyu-TV
//
//  Created by 刘亚勋 on 2016/10/10.
//  Copyright © 2016年 刘亚勋. All rights reserved.
//  HeaderView

import UIKit

class RecomandHeaderView: UICollectionReusableView {
    
    /// 更多按钮
    @IBOutlet public weak var moreBtn: UIButton!
    /// 分组标题
    @IBOutlet public weak var tagNameLabel: UILabel!
    /// 分组的icon
    @IBOutlet public weak var section_icon: UIImageView!
    
    
    
    /// 直播组模型
    public var liveG : BaseLiveGroupModel? {
        
        didSet{
            tagNameLabel.text = liveG?.tag_name
            section_icon.image = UIImage.init(named: (liveG?.icon_url)!)
        }
    }
    
    
    /// 更多按钮的点击方法
    @IBAction func moreDataClick(_ sender: UIButton) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

extension RecomandHeaderView{
    
    class func viewFromNib() -> RecomandHeaderView  {
        
        return Bundle.main.loadNibNamed("RecomandHeaderView", owner: nil, options: nil)?.first as! RecomandHeaderView

    }
    
}

