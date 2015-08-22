//
//  APIResponse.swift
//  APISound
//
//  Created by archie on 15/6/21.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import Foundation
import Alamofire

public struct APIResponse: Response {
    let mResponse: NSHTTPURLResponse?
    private let mBody: String?
    private let mStatusCode: Int?
    
    init(response: NSHTTPURLResponse?, body: String?) {
        self.mResponse = response
        self.mBody = body
        self.mStatusCode = response?.statusCode
    }
    
    public func getStatusLine() -> String? {
        if let status = mStatusCode {
            return "\(status) \(NSHTTPURLResponse.localizedStringForStatusCode(status).capitalizedString)"
        } else {
            return nil
        }
    }
    
    public func getFormattedHeader() -> String? {
        
        if let res = mResponse {
            var resString = ""
            for (key, value) in res.allHeaderFields {
                resString += "\(key): \(value)\n"
            }
            
            return resString
        }
        
        return nil
    }
    
    public func getBody() -> String? {
        return mBody
    }
}

public protocol Response {
    func getBody() -> String?
    func getStatusLine() -> String?
    func getFormattedHeader() -> String?
}
