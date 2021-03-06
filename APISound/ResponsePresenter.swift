//
//  ResponsePresenter.swift
//  APISound
//
//  Created by archie on 15/8/10.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import Foundation

public class ResponsePresenter: BasePresenter {
    let mRequest: APIRequest
    let mFetcher: Fetcher
    var mResponse: Response?
    weak var mResponseUi: ResponseUi?
    
    public init(apiRequest: APIRequest, fetcher: Fetcher = HttpFetcher()) {
        mRequest = apiRequest
        mFetcher = fetcher
    }
    
    override weak var mUi: BaseUi! {
        didSet {
            if let ui = mUi as? ResponseUi {
                mResponseUi = ui
            }
        }
    }
    
    override func populateUi() {
        self.mResponseUi?.setLoadingIndicatorHidden(false)
        self.mResponseUi?.setUiCallbacks(self)
        mFetcher.execute(mRequest) { [weak self] response in
            
            if let s = self {
                s.mResponseUi?.setLoadingIndicatorHidden(true)
                s.mResponse = response
                if let statusLine = response?.getStatusLine() {
                    s.mResponseUi?.setStatusLine(statusLine)
                } else {
                    s.mResponseUi?.setStatusLineHidden(true)
                }
                s.onShowBody()
            }

        }
    }
    
}

extension ResponsePresenter: ResponseUiCallbacks {
    public func onShowHeaders() {
        if let header = mResponse?.getFormattedHeader() {
            mResponseUi?.setMainText(header)
        } else {
            mResponseUi?.setNoResponseHintHidden(false)
        }
        
        
    }
    public func onShowBody() {
        if let body = mResponse?.getBody() {
            mResponseUi?.setMainText(JSONStringify(body) ?? body)
        } else {
            mResponseUi?.setNoResponseHintHidden(false)
        }
        
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