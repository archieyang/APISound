//
//  ResponsePresenter.swift
//  APISound
//
//  Created by archie on 15/8/10.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import Foundation

public class ResponsePresenter: BasePresenter {
    var mResponseUi: ResponseUi?
    var mRequest: APIRequest
    var mResponse: APIResponse?
    
    init(apiRequest: APIRequest) {
        mRequest = apiRequest
    }
    
    override var mUi: BaseUi! {
        didSet {
            if let ui = mUi as? ResponseUi {
                mResponseUi = ui
            }
        }
    }
    
    override func populateUi() {
        self.mResponseUi?.setLoadingIndicatorHidden(false)
        self.mResponseUi?.setUiCallbacks(self)
        HttpFetcher().execute(mRequest) { response in
            self.mResponseUi?.setLoadingIndicatorHidden(true)
            self.mResponse = response
            self.mResponseUi?.setStatusLine(response?.getStatusLine())
            self.onShowBody()
        }
    }
    
}

extension ResponsePresenter: ResponseUiCallbacks {
    public func onShowHeaders() {
        mResponseUi?.setHeaders(mResponse?.getFormattedHeader())
    }
    public func onShowBody() {
        mResponseUi?.setBody(JSONStringify(mResponse?.mBody) ?? mResponse?.mBody)
    }
    
    private func JSONStringify(jsonString: String?) -> String? {
        
        if let data = jsonString?.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            if let jsonObject: AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil) {
                if let formattedData = NSJSONSerialization.dataWithJSONObject(jsonObject, options: NSJSONWritingOptions.PrettyPrinted, error: nil) {
                    return NSString(data:formattedData, encoding: NSUTF8StringEncoding) as? String
                }
            }
        }
        
        return nil
    }
    
}

public protocol ResponseUiCallbacks: BaseUiCallbacks {
    func onShowHeaders() -> Void
    func onShowBody() -> Void
}