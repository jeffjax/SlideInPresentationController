//
//  TestViewController.swift
//  SlideInPresentationController
//
//  Created by Jeff Jackson on 8/20/14.
//  Copyright (c) 2014 Esri. All rights reserved.
//

import UIKit

// TODO: this should not need to conform to UIViewControllerTransitioningDelegate

class TestViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    var dismiss: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        preferredContentSize = CGSize(width: 320, height: 150)
    }

    @IBAction func close(sender: AnyObject) {
        dismiss?()
    }
    
    @IBAction func grow(sender: UIButton) {
        preferredContentSize = CGSize(width: 320, height: 300)
        sender.enabled = false
    }
    
    // TODO: Remove these methods
    //
    func presentationControllerForPresentedViewController(presented: UIViewController!, presentingViewController presenting: UIViewController!, sourceViewController source: UIViewController!) -> UIPresentationController! {
        
        return SlideInPresentationController(presentedViewController: presented, presentingViewController: presenting)
    }
    
    func animationControllerForPresentedController(presented: UIViewController!, presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        
        return SlideInAnimationController(isPresenting: true)
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        
        return SlideInAnimationController(isPresenting: false)
    }

}
