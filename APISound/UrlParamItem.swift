//
//  UrlParamItem.swift
//  
//
//  Created by archie on 15/6/17.
//
//

import Foundation
import CoreData

class UrlParamItem: NSManagedObject {

    @NSManaged var key: String
    @NSManaged var value: String
    @NSManaged var request: RequestDataItem

}
