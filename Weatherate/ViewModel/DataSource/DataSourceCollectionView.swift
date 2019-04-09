//
//  DataSourceCollectionView.swift
//  Weatherate
//
//  Created by Valodya Galstyan on 4/8/19.
//  Copyright © 2019 Valodya Galstyan. All rights reserved.
//

import UIKit

typealias CollectionViewCellBlock = (_ cell : BaseCollectionViewCell, _ id:AnyObject, _ isEditing: Bool) -> ()


class DataSourceCollectionView: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var items: NSMutableArray = []
    var cellIdentifier: String = ""
    var isEditing: Bool = false
    //weak var delegate: DataSourceCollectionViewDelegate?

    var configureCellBlock: CollectionViewCellBlock = {_,_,_ in }
    
    init(_ anItems: NSArray, aCellIdentifier: String, aConfigureCellBlock: @escaping CollectionViewCellBlock)  {
        
        super.init()
        self.items = anItems.mutableCopy() as! NSMutableArray
        self.cellIdentifier = aCellIdentifier
        self.configureCellBlock = aConfigureCellBlock
        self.isEditing = false
    }
    
    func setItems(anItems: NSArray) {
        items = anItems.mutableCopy() as! NSMutableArray
    }
    
    func itemAtIndexPath(indexPath: IndexPath) -> AnyObject {
        
        var item: AnyObject = "" as AnyObject
        if (indexPath.section < items.count) {
            
            item = items.object(at: indexPath.section) as AnyObject
        }
        
        return item
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return items.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item:BaseViewModel = self.itemAtIndexPath(indexPath: indexPath) as! BaseViewModel

        cellIdentifier = item.cellIdentifier
        
        let cell: UICollectionViewCell  = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        
        cell.bounds = CGRect(x:0, y:0, width:collectionView.frame.size.width / 6, height:cell.bounds.height)
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        
        self.configureCellBlock(cell as! BaseCollectionViewCell, item as AnyObject, self.isEditing)
        
        return cell
    }
   
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width / 6, height: collectionView.frame.size.height)
    }

}

