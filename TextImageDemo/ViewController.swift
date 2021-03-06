//
//  ViewController.swift
//  TextImageDemo
//
//  Created by yangyang on 15/11/5.
//  Copyright © 2015年 LLZ. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let cellIdentifier = "cellidentifier"
    let kCountKey = "CountKey"
    
    var dataSource = []
    
    @IBOutlet weak var tableView: UITableView!

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        p_refresh()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }
    

    //MARK: - Methods
    
    func p_refresh() {
        dataSource = ItemModel.sharedItemModel.p_getAllItem()
        
        tableView.reloadData()
    }
    
    @IBAction func p_saveAll(sender: AnyObject) {
        for (var i=0;i<dataSource.count;i++) {
            let entity = dataSource[i] as! ItemEntity
            
            FileManager.sharedFileManager.p_saveCache(entity.itemString, cacheFileName: "\(i)")
        }
        
        NSUserDefaults.standardUserDefaults().setInteger(dataSource.count, forKey: kCountKey)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    @IBAction func p_readAll(sender: AnyObject) {
        let count = NSUserDefaults.standardUserDefaults().integerForKey(kCountKey)
        
        var ary = [ItemEntity]()
        for (var i=0;i<count;i++) {
            let itemString = FileManager.sharedFileManager.p_readCache("\(i)")
            let entity = ItemEntity(itemString: itemString as! NSAttributedString)
            ary.append(entity)
        }
        
        ItemModel.sharedItemModel.p_setItems(ary)
        
        p_refresh()
    }
    
    
    //MARK: - Actions
    
    //MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! TextItemTableViewCell

        let entity = dataSource[indexPath.row] as? ItemEntity
        
        //TODO: 没有设计图片预览，所以只会预览文字
        
        cell.textPreviewLabel.text =  entity?.itemString.string
        
        return cell
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("\(indexPath.row) selected")
        
        let entity = dataSource[indexPath.row] as? ItemEntity
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("EditViewController") as! EditViewController
        
        vc.p_editSetup(entity!)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

