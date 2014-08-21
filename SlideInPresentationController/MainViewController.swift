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

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Test", style: .Plain, target: self, action: Selector("test:"))
    }

    func test(barButtonItem: UIBarButtonItem) {
        
        let toolsVC = ToolsViewController(nibName:nil, bundle: nil)
        
        if traitCollection.horizontalSizeClass != .Compact {
            toolsVC.modalPresentationStyle = .Popover
            toolsVC.popoverPresentationController.barButtonItem = barButtonItem
           
        } else {
            toolsVC.modalPresentationStyle = .Custom
            toolsVC.transitioningDelegate = SlideInTransitioner.sharedInstance
        }
        
        toolsVC.dismiss = {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        presentViewController(toolsVC, animated: true, completion: nil)
    }
}
