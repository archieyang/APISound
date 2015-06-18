//
//  UrlParamTableViewDataSource.swift
//  APISound
//
//  Created by archie on 15/6/7.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import UIKit

class UrlParamTableViewDataSource: NSObject, UITableViewDataSource {
    unowned var mainViewController: MainViewController
    
    init(controller: MainViewController) {
        mainViewController = controller
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainViewController.apiRequest!.urlParamList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("urlParamCell", forIndexPath: indexPath) as! UrlParamCell
        cell.urlParam = mainViewController.apiRequest!.urlParamList[indexPath.row]
        cell.accessibilityLabel = "URL Param \(indexPath.row)"
        cell.paramKeyLabel.accessibilityLabel = "URL Param Key \(indexPath.row)"
        cell.paramValueLabel.accessibilityLabel = "URL Param Value \(indexPath.row)"
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            mainViewController.apiRequest!.urlParamList.removeAtIndex(indexPath.row)
            mainViewController.urlParamsTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }

    }
}
