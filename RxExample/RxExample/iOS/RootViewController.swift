//
//  RootViewController.swift
//  RxExample
//
//  Created by Krunoslav Zaher on 4/6/15.
//  Copyright (c) 2015 Krunoslav Zaher. All rights reserved.
//

import Foundation
import UIKit
#if !RX_NO_MODULE
    import RxSwift
    import RxCocoa
#endif

public class RootViewController : UITableViewController {
    var timeFormatter = NSDateFormatter()
    public override func viewDidLoad() {
        super.viewDidLoad()
        timeFormatter.dateFormat = "HH:mm:ss.SSS"
        //NSTimer.scheduledTimerWithTimeInterval(0.001, target: self, selector: "doIt", userInfo: nil, repeats: true)
        // force load
        GitHubSearchRepositoriesAPI.sharedAPI.activityIndicator
        DefaultWikipediaAPI.sharedAPI
        DefaultImageService.sharedImageService
        DefaultWireframe.sharedInstance
        MainScheduler.sharedInstance
        ReachabilityService.sharedReachabilityService
    }

    public func doIt() {
        print("\(timeFormatter.stringFromDate(NSDate())): \(RxSwift.resourceCount)")
    }
}