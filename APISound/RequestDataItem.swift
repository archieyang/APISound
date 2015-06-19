//
//  RequestDataItem.swift
//  
//
//  Created by archie on 15/6/19.
//
//

import Foundation
import CoreData

class RequestDataItem: NSManagedObject {

    @NSManaged var method: String
    @NSManaged var url: String
    @NSManaged var lastRequestTime: NSDate
    @NSManaged var params: NSOrderedSet

}
