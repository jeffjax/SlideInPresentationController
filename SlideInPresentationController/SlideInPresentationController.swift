/*

COPYRIGHT 2014 ESRI

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>

*/

import UIKit

class SlideInPresentationController: UIPresentationController {

    lazy var dimmingView: UIView = {
        let view = UIView(frame: self.containerView!.bounds)
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        view.alpha = 0
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("dimmingViewTapped:")))
        return view
    }()

    func dimmingViewTapped(gesture: UIGestureRecognizer) {
        presentingViewController.dismissViewControllerAnimated(true, completion: nil)
    }

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
        let size = presentedViewController.preferredContentSize
        return CGSize(width: parentSize.width, height: size.height == 0 ? parentSize.height / 3 : size.height)
    }

    override func containerViewWillLayoutSubviews() {
        dimmingView.frame = containerView.bounds
        presentedViewController.view.frame = frameOfPresentedViewInContainerView()
    }

    // MARK: UIContentContainer protocol methods

    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator transitionCoordinator: UIViewControllerTransitionCoordinator!) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: transitionCoordinator)

        transitionCoordinator.animateAlongsideTransition({(context: UIViewControllerTransitionCoordinatorContext!) -> Void in
            self.dimmingView.frame = self.containerView.bounds
        }, completion: nil)
    }

    override func preferredContentSizeDidChangeForChildContentContainer(container: UIContentContainer!) {

        if let containerView = containerView {
            let size = CGSize(width: containerView.bounds.width, height: presentedViewController.preferredContentSize.height)
            presentedViewController.viewWillTransitionToSize(size, withTransitionCoordinator: presentedViewController.transitionCoordinator())
            presentedViewController.view.frame = frameOfPresentedViewInContainerView()
        }
    }

}

