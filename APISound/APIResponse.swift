//
//  APIResponse.swift
//  APISound
//
//  Created by archie on 15/6/21.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import Foundation
import Alamofire

class APIResponse {
    var response: NSHTTPURLResponse?
    var body: String?
    
    init(response: NSHTTPURLResponse?, body: String?) {
        self.response = response
        self.body = body
    }
    
    func getFormattedHeader() -> String? {
        
        if let res = response {
            var resString = ""
            for (key, value) in res.allHeaderFields {
                resString += "\(key): \(value)\n"
            }
            
            return resString
        }
        
        return nil
    }
}
