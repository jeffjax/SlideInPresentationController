//
//  SlideInTransitioner.swift
//  SlideInPresentationController
//
//  Created by Jeff Jackson on 8/20/14.
//  Copyright (c) 2014 Esri. All rights reserved.
//

import UIKit

class SlideInTransitioner : NSObject, UIViewControllerTransitioningDelegate {
    
    private override init() {
        super.init()
    }
    
    class var sharedInstance : SlideInTransitioner {
    struct Static {
        static let instance = SlideInTransitioner()
        }
        return Static.instance
    }
    
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
