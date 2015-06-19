//
//  APIRequestManager.swift
//  APISound
//
//  Created by archie on 15/6/19.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class APIRequestManager {
    static let sharedInstance = APIRequestManager()
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    private init() {
        
    }
    
    internal func fetchAll(callback: ([APIRequest]) -> Void) -> Void {
        
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