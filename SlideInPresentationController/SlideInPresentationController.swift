//
//  SlideInPresentationController.swift
//  SlideInPresentationController
//
//  Created by Jeff Jackson on 8/20/14.
//  Copyright (c) 2014 Esri. All rights reserved.
//

import UIKit

class SlideInPresentationController: UIPresentationController {

    lazy var dimmingView: UIView = {
        let view = UIView(frame: self.containerView!.bounds)
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        view.alpha = 0
        return view
    }()

    override func presentationTransitionWillBegin() {

        dimmingView.frame = containerView.bounds
        containerView.addSubview(dimmingView)
        containerView.addSubview(presentedView())

        // fade in the dimming view alongside the transition
        //
        let transitionCoordinator = presentingViewController.transitionCoordinator()
        transitionCoordinator.animateAlongsideTransition({(context: UIViewControllerTransitionCoordinatorContext!) -> Void in
            self.dimmingView.alpha  = 1.0
        }, completion: nil)
    }

    override func presentationTransitionDidEnd(completed: Bool)  {
        // if the presentation didn't complete, remove the dimming view
        //
        if !completed {
            dimmingView.removeFromSuperview()
        }
    }

    override func dismissalTransitionWillBegin()  {
        // fade out the dimming view alongside the transition
        //
        let transitionCoordinator = presentingViewController.transitionCoordinator()
        transitionCoordinator.animateAlongsideTransition({(context: UIViewControllerTransitionCoordinatorContext!) -> Void in
            self.dimmingView.alpha  = 0.0
        }, completion: nil)
    }

    override func dismissalTransitionDidEnd(completed: Bool) {
        // if the dismissal completed, remove the dimming view
        //
        if completed {
            self.dimmingView.removeFromSuperview()
        }
    }

    override func frameOfPresentedViewInContainerView() -> CGRect {
        var frame = CGRectZero
        var containerBounds = containerView.bounds
        frame.size = sizeForChildContentContainer(presentedViewController, withParentContainerSize: containerBounds.size)
        frame.origin.y = containerBounds.height - frame.height
        
        return frame
    }

    override func sizeForChildContentContainer(container: UIContentContainer!, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: parentSize.width, height: parentSize.height / 3)
    }

    override func containerViewWillLayoutSubviews() {
        dimmingView.frame = containerView.bounds
        presentedViewController.view.frame = frameOfPresentedViewInContainerView()
    }

    // ---- UIContentContainer protocol methods

    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator transitionCoordinator: UIViewControllerTransitionCoordinator!) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: transitionCoordinator)

        transitionCoordinator.animateAlongsideTransition({(context: UIViewControllerTransitionCoordinatorContext!) -> Void in
            self.dimmingView.frame = self.containerView.bounds
        }, completion: nil)
    }
}

