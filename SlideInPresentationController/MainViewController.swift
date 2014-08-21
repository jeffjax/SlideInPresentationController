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

class MainViewController: UIViewController {

    let toggle = UISwitch(frame: CGRectZero)
   
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Tools", style: .Plain, target: self, action: Selector("showTools:"))
    }

    func showTools(barButtonItem: UIBarButtonItem) {
        
        let toolsVC = ToolsViewController(nibName:nil, bundle: nil)
        
        // use a popover to show the tools vc if we can
        //
        if traitCollection.horizontalSizeClass != .Compact {
            toolsVC.modalPresentationStyle = .Popover
            toolsVC.popoverPresentationController.barButtonItem = barButtonItem
           
        } else {
            // use our custom presentation controller
            //
            toolsVC.modalPresentationStyle = .Custom
            toolsVC.transitioningDelegate = SlideInTransitioner.sharedInstance
        }
        
        toolsVC.dismiss = {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        presentViewController(toolsVC, animated: true, completion: nil)
    }
}
