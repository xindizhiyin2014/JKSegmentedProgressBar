//
//  ViewController.swift
//  JKSegmentedProgressBar
//
//  Created by xindizhiyin2014 on 04/17/2019.
//  Copyright (c) 2019 xindizhiyin2014. All rights reserved.
//

import UIKit
import JKSegmentedProgressBar
class ViewController: UIViewController {
    
//    @objc func injected(){
//        self.loadView()
//        self.viewDidLoad()
//        self.viewDidLayoutSubviews()
//        self.viewWillAppear(false)
//        self.viewDidDisappear(false)
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = .green
        self.automaticallyAdjustsScrollViewInsets = false
        let segmentedProgressBar:JKSegmentedProgressBar = JKSegmentedProgressBar.init(frame:CGRect.init(x: 0, y: 100, width: self.view.frame.width, height: 50))
        self.view.addSubview(segmentedProgressBar)
        segmentedProgressBar.itemCount = 3
        segmentedProgressBar.itemSpace = 10
        segmentedProgressBar.updateProgress(indexPath: NSIndexPath.init(row: 1, section: 0) as NSIndexPath, progress: 0.5)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

