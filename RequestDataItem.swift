//
//  RequestDataItem.swift
//  
//
//  Created by archie on 15/6/14.
//
//

import Foundation
import CoreData

class RequestDataItem: NSManagedObject {

    @NSManaged var url: String
    @NSManaged var method: String

}
