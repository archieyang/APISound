//
//  Request.swift
//  APISound
//
//  Created by archie on 15/6/17.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import Foundation
import UIKit
import CoreData

public class APIRequest {
    private var requestDataItem: RequestDataItem?
    
    var url: String
    var method: String
    var urlParamList: [UrlParam]
    var headerList:[UrlParam]
    var lastRequestTime: NSDate!
    
    public init(method: String, url: String, urlParamList: [UrlParam], headerList: [UrlParam]) {
        self.url = url
        self.method = method
        self.urlParamList = urlParamList
        self.headerList = headerList
    }
    
    public init(method: String, url: String) {
        self.url = url
        self.method = method
        self.urlParamList = [UrlParam]()
        self.headerList = [UrlParam]()
    }
    
    init(requestDataItem: RequestDataItem) {
        self.requestDataItem = requestDataItem
        
        url = requestDataItem.url
        method = requestDataItem.method
        urlParamList = [UrlParam]()
        headerList = [UrlParam]()
        
        for param in requestDataItem.params.array as! [UrlParamItem] {
            urlParamList.append(UrlParam(k: param.key, v: param.value))
        }
    }
    
    public func save() -> Void {
        let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        
        //In Swift 2.0 can change to guard sentence
        if let item = requestDataItem {
            
        } else {
            requestDataItem = NSEntityDescription.insertNewObjectForEntityForName("RequestDataItem", inManagedObjectContext: managedObjectContext!) as? RequestDataItem
        }

        
        if let item = requestDataItem {
            item.method = method
            item.url = url
            item.lastRequestTime = lastRequestTime
            
            var paramSet = [AnyObject]()
            for item in urlParamList {
                let newUrlParam = NSEntityDescription.insertNewObjectForEntityForName("UrlParamItem", inManagedObjectContext: managedObjectContext!) as! UrlParamItem
                newUrlParam.key = item.key
                newUrlParam.value = item.value
                paramSet.append(newUrlParam)
            }
                
            item.params = NSOrderedSet(array: paramSet)
            
        }

    }
}