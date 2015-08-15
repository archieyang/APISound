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
    
    enum Section: Int {
        case Header = 0, UrlParam = 1
    }
    
    init(controller: MainViewController) {
        mainViewController = controller
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == Section.Header.rawValue {
            return mainViewController.apiRequest!.headerList.count
        } else {
            return mainViewController.apiRequest!.urlParamList.count
        }
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if self.tableView(tableView, numberOfRowsInSection: section) == 0 {
            return nil
        }
        
        if section == Section.Header.rawValue {
            return "Headers"
        } else {
            return "URL Parameters"
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("urlParamCell", forIndexPath: indexPath) as! UrlParamCell
        
        if indexPath.section == Section.Header.rawValue {
            cell.urlParam = mainViewController.apiRequest!.headerList[indexPath.row]
        } else {
            cell.urlParam = mainViewController.apiRequest!.urlParamList[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            if indexPath.section == Section.Header.rawValue {
                mainViewController.apiRequest!.headerList.removeAtIndex(indexPath.row)
            } else {
                mainViewController.apiRequest!.urlParamList.removeAtIndex(indexPath.row)
            }
            
            mainViewController.urlParamsTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }

    }
}
