//
//  ViewController.swift
//  RxExample
//
//  Created by Krunoslav Zaher on 4/25/15.
//  Copyright (c) 2015 Krunoslav Zaher. All rights reserved.
//

import Foundation
#if !RX_NO_MODULE
import RxSwift
#endif

#if os(iOS)
    import UIKit
    typealias OSViewController = UIViewController
#elseif os(OSX)
    import Cocoa
    typealias OSViewController = NSViewController
#endif

class ViewController: OSViewController {
#if TRACE_RESOURCES
    #if !RX_NO_MODULE
    private let startResourceCount = RxSwift.resourceCount
    #else
    private let startResourceCount = resourceCount
    #endif
#endif

    var disposeBag = DisposeBag()

    override func viewDidLoad() {
#if TRACE_RESOURCES
        print("Number of start resources = \(resourceCount)")
#endif
    }
    
    deinit {
#if TRACE_RESOURCES
        print("View controller disposed with \(resourceCount) resources")
    
        let numberOfResourcesThatShouldRemain = startResourceCount
        let timeInt0 = dispatch_time(DISPATCH_TIME_NOW, Int64(0.0001 * Double(NSEC_PER_SEC)))
        let time0 = NSDate()
        dispatch_after(timeInt0, dispatch_get_main_queue()) {
            let time1 = NSDate()
            print(time1.timeIntervalSinceDate(time0))
            
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(0.03 * Double(NSEC_PER_SEC)))
            dispatch_after(time, dispatch_get_main_queue()) {
                let time2 = NSDate()
                print(time2.timeIntervalSinceDate(time1))
                let areTheyCleaned = resourceCount <= numberOfResourcesThatShouldRemain
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.05 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
                    assert(areTheyCleaned, "Resources weren't cleaned properly")
                }
            }
        }
#endif
    }
}