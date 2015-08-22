//
//  HttpFetcher.swift
//  APISound
//
//  Created by archie on 15/5/29.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import Foundation
import Alamofire

public class HttpFetcher: Fetcher {
    public static let METHODS = ["GET", "POST"]
    
    public func execute(request: APIRequest, callback: (Response?) -> Void) {
        var params = [String: AnyObject]()
        
        for urlParam in request.mUrlParamList {
            params[urlParam.key] = urlParam.value
            println(urlParam.key + urlParam.value)
        }
        
        var headers = [String : String]()
        
        for headerItem in request.mHeaderList {
            headers[headerItem.key] = headerItem.value
        }

        Alamofire.request(request.mMethod == HttpFetcher.METHODS[0] ? .GET : .POST, request.mUrl, parameters: params, headers: headers).responseString {
            [weak self] (_, response, string, _) in

            callback(APIResponse(response: response, body: string))
        }
    }
    
}

public protocol Fetcher {
    func execute(request: APIRequest, callback: (Response?) -> Void)
}
