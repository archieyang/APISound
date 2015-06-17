//
//  HttpFetcher.swift
//  APISound
//
//  Created by archie on 15/5/29.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import Foundation
import Alamofire

class HttpFetcher {
    internal func fetch(url: String, urlParamList: [UrlParam], callback: (String?) -> Void) {
        
        var params = [String: AnyObject]()
        for urlParam in urlParamList {
            params[urlParam.key] = urlParam.value
            println(urlParam.key + urlParam.value)
        }
        Alamofire.request(.GET, url, parameters: params).responseString {
            (_, _, string, _) in
            callback(string)
        }
    }
    
    func execute(request: APIRequest, callback: (String?) -> Void) {
        var params = [String: AnyObject]()
        
        for urlParam in request.urlParamList {
            params[urlParam.key] = urlParam.value
            println(urlParam.key + urlParam.value)
        }
        
        Alamofire.request(.GET, request.url, parameters: params).responseString {
            (_, _, string, _) in
            callback(string)
        }
    }
    
}
