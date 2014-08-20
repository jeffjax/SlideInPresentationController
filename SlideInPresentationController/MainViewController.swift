//
//  MainViewController.swift
//  SlideInPresentationController
//
//  Created by Jeff Jackson on 8/20/14.
//  Copyright (c) 2014 Esri. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    let toggle = UISwitch(frame: CGRectZero)
   
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Test", style: .Plain, target: self, action: Selector("test"))
        
        toggle.onTintColor = UIColor.lightGrayColor()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: toggle)
    }

    func test() {
        
        let testVC = TestViewController(nibName: "TestViewController", bundle: nil)
        
        if toggle.on {
            testVC.modalPresentationStyle = .Custom
            testVC.transitioningDelegate = SlideInTransitioner.sharedInstance
        }
        
        testVC.dismiss = {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        presentViewController(testVC, animated: true, completion: nil)
    }
}
