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

class ToolsViewController: UITableViewController {
  
    var dismiss: (() -> Void)?

    let names = [ "Sketch", "Measure", "Legend", "GPS", "Search"]
    let images = [ "sketch", "measure", "legend", "gps", "search"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "CONTENT")
        
        // calculate preferredContentSize
        //
        tableView.layoutIfNeeded()
        preferredContentSize = CGSize(width: 320, height: tableView.contentSize.height)
    }

    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }

    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("CONTENT", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel.text = names[indexPath.row]
        cell.imageView.image = UIImage(named: images[indexPath.row])
        
        return cell
    }
    
    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        dismiss?()
    }
 
}
