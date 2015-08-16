//
//  HttpFetcher.swift
//  APISound
//
//  Created by archie on 15/5/29.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import Foundation
import Alamofire

public class HttpFetcher {
    public static let METHODS = ["GET", "POST"]
    
    func execute(request: APIRequest, callback: (APIResponse?) -> Void) {
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
            (_, response, string, _) in

            callback(APIResponse(response: response, body: string))
        }
    }
    
}
