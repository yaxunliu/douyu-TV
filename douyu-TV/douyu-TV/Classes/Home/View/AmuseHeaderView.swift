//
//  AmuseHeaderView.swift
//  Douyu-TV
//
//  Created by 刘亚勋 on 2016/10/14.
//  Copyright © 2016年 刘亚勋. All rights reserved.
//

import UIKit

let kAmuseHeaderCell = "kAmuseHeaderCell"

class AmuseHeaderView: UIView {

    /// collectionView
    @IBOutlet weak var collectionView: UICollectionView!
    /// pageControl
    @IBOutlet weak var pageControl: UIPageControl!
    /// 布局
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        collectionView.register(UINib.init(nibName: "AmuseHeaderCollectionCell", bundle: nil), forCellWithReuseIdentifier: kAmuseHeaderCell)

        layout.itemSize = self.collectionView.frame.size
        
        
    }
    
    
}

extension AmuseHeaderView{
    
    class func viewFromNib()->AmuseHeaderView {
    
        return Bundle.main.loadNibNamed("AmuseHeaderView", owner: nil, options: nil)?.first as! AmuseHeaderView
    
    }
}

extension AmuseHeaderView :UICollectionViewDataSource,UICollectionViewDelegate{
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kAmuseHeaderCell, for: indexPath) as! AmuseHeaderCollectionCell
        
        return  cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
}


