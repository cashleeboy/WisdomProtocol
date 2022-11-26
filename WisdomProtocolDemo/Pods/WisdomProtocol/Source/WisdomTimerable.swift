//
//  WisdomTimerable.swift
//  Pods
//
//  Created by 汤建锋 on 2022/11/24.
//

import UIKit


// MARK: Class Timerable Protocol
// * Support for objective-c/Swift Class
@objc public protocol WisdomTimerable {
    
    // MARK: Class Param - NSInteger, WisdomTimerable
    // * Timer task in progress, current time
    func timerable(timerDid currentTime: NSInteger, timerable: WisdomTimerable)
    
    // MARK: Class Param - WisdomTimerable
    // * Example End a scheduled task
    func timerable(timeEnd timerable: WisdomTimerable)
}

extension WisdomTimerable {
    
    // MARK: Class Param - NSInteger
    // * Start a timer task, start the timer time point
    public func startAddTimer(startTime: NSInteger){
        WisdomProtocolCore.startAddTimer(able: self, startTime: startTime)
    }
    
    // MARK: Class Param - NSInteger
    // * Start a countdown task, start the total time countdown 
    public func startDownTimer(totalTime: NSInteger){
        WisdomProtocolCore.startDownTimer(able: self, totalTime: totalTime)
    }
    
    // MARK: Class Timer - suspend
    //public func suspendTimer(){
    //    WisdomProtocolCore.suspendTimer(able: self)
    //}
    
    // MARK: Class Timer - resume
    //public func resumeTimer(){
    //    WisdomProtocolCore.resumeTimer(able: self)
    //}
    
    // MARK: Class Timer - destroy
    public func destroyTimer(){
        WisdomProtocolCore.destroyTimer(able: self)
    }
}