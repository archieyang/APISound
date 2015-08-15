//
//  APIResponse.swift
//  APISound
//
//  Created by archie on 15/6/21.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import Foundation
import Alamofire

struct APIResponse {
    let response: NSHTTPURLResponse?
    let body: String?
    private let statusCode: Int?
    
    init(response: NSHTTPURLResponse?, body: String?) {
        self.response = response
        self.body = body
        self.statusCode = response?.statusCode
    }
    
    func getStatusLine() -> String? {
        if let status = statusCode {
            return "\(status) \(NSHTTPURLResponse.localizedStringForStatusCode(status).capitalizedString)"
        } else {
            return nil
        }
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
