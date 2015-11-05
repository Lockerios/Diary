//
//  EditViewController.swift
//  TextImageDemo
//
//  Created by yangyang on 15/11/5.
//  Copyright © 2015年 LLZ. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var saveBBI: UIBarButtonItem!
    
    var toolbar: UIToolbar!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        saveBBI.enabled = false
        
        toolbar = UIToolbar(frame: CGRectMake(0,0,SCREEN_WIDTH,44))
        toolbar.items = [
            UIBarButtonItem.init(title: "图片", style: .Plain, target: self, action: Selector("p_addImage")),
            UIBarButtonItem.init(barButtonSystemItem: .FlexibleSpace, target: self, action: nil),
            UIBarButtonItem.init(title: "收起", style: .Plain, target: self, action: Selector("p_hideKB")),
        ]
        textView.inputAccessoryView = toolbar
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        textView.becomeFirstResponder()
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
    
    func p_hideKB() {
        textView.resignFirstResponder()
    }
    
    func p_addImage() {
        
    }
    
    @IBAction func p_save(sender: AnyObject) {
        ItemModel.sharedItemModel.p_addItem(ItemEntity.init(itemString: textView.text))
        
        self.navigationController?.popViewControllerAnimated(true)
    }

    //MARK: - Actions
    
    //MARK: UITextViewDelegate
    
    func textViewDidChange(textView: UITextView) {
        saveBBI.enabled = textView.text.characters.count > 0
    }
}
