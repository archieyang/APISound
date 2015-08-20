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
    
    public var mUrl: String
    public var mMethod: String
    public var mUrlParamList: [UrlParam]
    public var mHeaderList:[UrlParam]
    public var mLastRequestTime: NSDate!
    
    public init(method: String, url: String, urlParamList: [UrlParam], headerList: [UrlParam], lastRequestTime: NSDate = NSDate()) {
        self.mUrl = url
        self.mMethod = method
        self.mUrlParamList = urlParamList
        self.mHeaderList = headerList
        self.mLastRequestTime = lastRequestTime
    }
    
    public init(method: String, url: String, lastRequestTime: NSDate = NSDate()) {
        self.mUrl = url
        self.mMethod = method
        self.mUrlParamList = [UrlParam]()
        self.mHeaderList = [UrlParam]()
        self.mLastRequestTime = lastRequestTime
    }
    
    init(requestDataItem: RequestDataItem) {
        self.requestDataItem = requestDataItem
        
        mUrl = requestDataItem.url
        mMethod = requestDataItem.method
        mUrlParamList = [UrlParam]()
        mHeaderList = [UrlParam]()
        mLastRequestTime = requestDataItem.lastRequestTime
        
        for param in requestDataItem.params.array as! [UrlParamItem] {
            mUrlParamList.append(UrlParam(k: param.key, v: param.value))
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
            item.method = mMethod
            item.url = mUrl
            item.lastRequestTime = mLastRequestTime
            
            var paramSet = [AnyObject]()
            for item in mUrlParamList {
                let newUrlParam = NSEntityDescription.insertNewObjectForEntityForName("UrlParamItem", inManagedObjectContext: managedObjectContext!) as! UrlParamItem
                newUrlParam.key = item.key
                newUrlParam.value = item.value
                paramSet.append(newUrlParam)
            }
                
            item.params = NSOrderedSet(array: paramSet)
            
        }

    }
}