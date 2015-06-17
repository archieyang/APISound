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
    private let requestDataItem: RequestDataItem
    
    var url: String {
        return requestDataItem.url
    }
    
    var method: String {
        return requestDataItem.method
    }
    
    var urlParamList: [UrlParam] {
        var list = [UrlParam]()
        for param in requestDataItem.params.array as! [UrlParamItem] {
            list.append(UrlParam(k: param.key, v: param.value))
        }
        return list
    }
    
    public init(method: String, url: String, urlParamList: [UrlParam]) {
        let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        requestDataItem = NSEntityDescription.insertNewObjectForEntityForName("RequestDataItem", inManagedObjectContext: managedObjectContext!) as! RequestDataItem
        requestDataItem.method = method
        requestDataItem.url = url
        
        var paramSet = [AnyObject]()
        for item in urlParamList {
            let newUrlParam = NSEntityDescription.insertNewObjectForEntityForName("UrlParamItem", inManagedObjectContext: managedObjectContext!) as! UrlParamItem
            newUrlParam.key = item.key
            newUrlParam.value = item.value
            paramSet.append(newUrlParam)
        }
        
        requestDataItem.params = NSOrderedSet(array: paramSet)
    }
    
    private init(requestDataItem: RequestDataItem) {
        self.requestDataItem = requestDataItem
    }
    
    public class func fetchAll(callback: ([APIRequest]) -> Void) -> Void {
        let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        var allRequests = [APIRequest]()
        
        let fetchRequest = NSFetchRequest(entityName: "RequestDataItem")
        if let requests = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [RequestDataItem] {
            for request in requests {
                allRequests.append(APIRequest(requestDataItem: request))
            }
        }
        
        callback(allRequests)

    }
}