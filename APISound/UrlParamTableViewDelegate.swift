//
//  UrlParamTableViewDelegate.swift
//  APISound
//
//  Created by archie on 15/6/6.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import UIKit

class UrlParamTableViewDelegate:NSObject, UITableViewDelegate {
    let showUrlParamDialog: (String, String,  UrlParam?, (UrlParam) -> Void) -> Void
    var urlParamList: [UrlParam]
    init(inout inputUrlParamList: [UrlParam],selectRowCallback: (String, message: String,  UrlParam?, (UrlParam) -> Void) -> Void) {
        showUrlParamDialog = selectRowCallback
        urlParamList = inputUrlParamList
        println("init")
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("clicked")
        showUrlParamDialog("Edit parameters", "Edit URL parameter", urlParamList[indexPath.row]){ (param) in
            self.urlParamList[indexPath.row] = param
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
}
