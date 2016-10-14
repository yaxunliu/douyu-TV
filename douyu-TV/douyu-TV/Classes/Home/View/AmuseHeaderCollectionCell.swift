//
//  AmuseHeaderCollectionCell.swift
//  Douyu-TV
//
//  Created by 刘亚勋 on 2016/10/14.
//  Copyright © 2016年 刘亚勋. All rights reserved.
//

import UIKit

private let kAmuseHeaderMenuCell = "kAmuseHeaderMenuCell"

class AmuseHeaderCollectionCell: UICollectionViewCell {

    /// collectionView
    @IBOutlet weak var amuseCollectionView: UICollectionView!
    /// layout
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layout.itemSize = CGSize(width: self.bounds.width / 4, height: self.bounds.height / 2)

        amuseCollectionView.register( UINib.init(nibName: "CollectionChannelCell", bundle: nil), forCellWithReuseIdentifier: kAmuseHeaderMenuCell)
        
    }

}

extension AmuseHeaderCollectionCell:UICollectionViewDataSource,UICollectionViewDelegate{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let menuCell = collectionView.dequeueReusableCell(withReuseIdentifier: kAmuseHeaderMenuCell, for: indexPath) as! CollectionChannelCell
    
        menuCell.backgroundColor = UIColor.red
        
        
        return menuCell
    }
    
    
}
