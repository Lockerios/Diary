//
//  ItemModel.swift
//  TextImageDemo
//
//  Created by yangyang on 15/11/5.
//  Copyright © 2015年 LLZ. All rights reserved.
//

import UIKit

private let sharedInstance = ItemModel()

class ItemEntity {
    
    //没有设计 ID 之类的识别，所以如果编辑，会多一个
    
    var itemString = NSAttributedString()
    
    init(itemString: NSAttributedString) {
        self.itemString = itemString
    }
}

class ItemModel {

    private var ItemArray = [ItemEntity]()
    
    //MARK: - Lifecycle
    
    class var sharedItemModel: ItemModel {
        return sharedInstance
    }
    
    //MARK: - Methods
    
    func p_getAllItem() -> [ItemEntity] {
        return ItemArray
    }
    
    func p_addItem(itemEntity: ItemEntity) {
        ItemArray.append(itemEntity)
    }
}
