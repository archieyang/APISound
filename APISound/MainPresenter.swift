//
//  MainPresenter.swift
//  APISound
//
//  Created by archie on 15/8/9.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import Foundation

class MainPresenter: BasePresenter {
    let METHODS = HttpFetcher.METHODS
    var mApiRequest: APIRequest?
    
    var mMainUi: MainUi?
    
    override var mUi: BaseUi! {
        didSet {
            if let ui = mUi as? MainUi {
                mMainUi = ui
            }
        }
    }
    
    override func onAttachToUi() {
        mUi.setUiCallbacks(self)
    }
    
    override func populateUi() {
        if let request = mApiRequest {
            
        } else {
            mApiRequest = APIRequest(method: METHODS[0], url: "")
        }
        
        if let request = mApiRequest {
            mMainUi?.setCurrentItem(mApiRequest!)
        }
        
    }
    
}

extension MainPresenter: MainUiCallbacks {

    func createNewRequest() -> APIRequest {
        mApiRequest = APIRequest(method: METHODS[0], url: "")
        return mApiRequest!
    }
    
    func addRequestParam(param: UrlParam) -> Void {
        if let request = mApiRequest {
            request.mUrlParamList.append(param)
        }
    }
    
    func addHeaderParam(param: UrlParam) {
        if let request = mApiRequest {
            request.mHeaderList.append(param)
        }
    }
    
    func getUrlParam(atIndex index: Int) -> UrlParam? {
        if index < 0 {
            return nil
        }
        
        if index >= mApiRequest!.mUrlParamList.count {
            return nil
        }
        
        return mApiRequest!.mUrlParamList[index]
    }
    
    func saveCurrentRequest() -> APIRequest? {
        if let request = mApiRequest, ui = mMainUi{
            let url = ui.getUrlString().stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            if url.hasPrefix("http://") || url.hasPrefix("https://") {
                request.mUrl = url
            } else {
                request.mUrl = "http://" + url
            }
            request.mMethod = mMainUi!.getMethodString()
            request.mLastRequestTime = NSDate()
            request.save()

            return request
        } else {
            return nil
        }

    }
    
    func isCurrentRequestValid() -> (valid: Bool, warningText: String?) {
        if let ui = mMainUi {
            if ui.getUrlString().stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).isEmpty {
                return (false, "URL should not be empty")
            } else {
                return (true, nil)
            }
        } else {
            return (false, nil)
        }
    }
}

protocol MainUiCallbacks: BaseUiCallbacks {
    func createNewRequest() -> APIRequest
    func addRequestParam(param: UrlParam) -> Void
    func addHeaderParam(param: UrlParam) -> Void
    func getUrlParam(atIndex index: Int) -> UrlParam?
    func saveCurrentRequest() -> APIRequest?
    func isCurrentRequestValid() -> (valid: Bool, warningText: String?)
}