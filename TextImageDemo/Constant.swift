//
//  Constant.swift
//  SportsStore
//
//  Created by yangyang on 15/10/29.
//  Copyright © 2015年 LLZ. All rights reserved.
//

import UIKit

extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
}

extension String {
    
    func stringByAppendingPathComponent(path: String) -> String {
        
        let nsSt = self as NSString
        
        return nsSt.stringByAppendingPathComponent(path)
    }
}

//MARK: Screen

let SCREEN_BOUNDS = UIScreen.mainScreen().bounds
let SCREEN_SCALE = UIScreen.mainScreen().scale
let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width
let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.size.height
let SCREEN_MAX_LENGTH = max(SCREEN_WIDTH, SCREEN_HEIGHT)
let SCREEN_MIN_LENGTH = min(SCREEN_WIDTH, SCREEN_HEIGHT)

//MARK: Device

let IS_IPAD = UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad
let IS_IPHONE = UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone

let IS_IPHONE_4_OR_LESS = (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
let IS_IPHONE_5 = (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
let IS_IPHONE_6 = (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
let IS_IPHONE_6P = (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

//MARK: System Version

let IS_OS_7_OR_LATER = (UIDevice.currentDevice().systemVersion as String).floatValue >= 7.0
let IS_OS_8_OR_LATER = (UIDevice.currentDevice().systemVersion as String).floatValue >= 8.0
let IS_OS_9_OR_LATER = (UIDevice.currentDevice().systemVersion as String).floatValue >= 9.0

//MARK: Macros

/** 
dLog macros to abbreviate NSLog.
    
Use like this:

dLog("Log this!")
**/

#if DEBUG
    func dLog(@autoclosure message:  () -> String, filename: String = __FILE__, function: String = __FUNCTION__, line: Int = __LINE__) {
        NSLog("[\(filename.stringByAppendingPathComponent):\(line)] \(function) - %@", message())
    }
#else
    func dLog(@autoclosure message:  () -> String, filename: String = __FILE__, function: String = __FUNCTION__, line: Int = __LINE__) {
    }
#endif
