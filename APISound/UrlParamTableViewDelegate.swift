//
//  UrlParamTableViewDelegate.swift
//  APISound
//
//  Created by archie on 15/6/6.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import UIKit

class UrlParamTableViewDelegate: NSObject, UITableViewDelegate {
    unowned let mainViewController: MainViewController

    init(controller: MainViewController) {
        mainViewController = controller
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        mainViewController.showUrlParamDialog("Edit", message: "Edit Key and Value", defaultUrlParams: mainViewController.callbacks!.getUrlParam(atIndex: indexPath.row)) { [unowned self] (newUrlParam) in
            self.mainViewController.apiRequest!.urlParamList[indexPath.row] = newUrlParam
            self.mainViewController.urlParamsTableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
}
