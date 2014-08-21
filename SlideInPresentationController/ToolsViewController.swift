//
//  ToolsViewController.swift
//  SlideInPresentationController
//
//  Created by Jeff Jackson on 8/20/14.
//  Copyright (c) 2014 Esri. All rights reserved.
//

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
