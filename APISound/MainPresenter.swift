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
    var apiRequest: APIRequest?
    
    var mainUi: MainUi?
    
    override var mUi: BaseUi! {
        didSet {
            if let ui = mUi as? MainUi {
                mainUi = ui
            }
        }
    }
    
    override func onAttachToUi() {
        mUi.setUiCallbacks(self)
    }
    
    override func populateUi() {
        if let request = apiRequest {
            
        } else {
            apiRequest = APIRequest(method: METHODS[0], url: "")
        }
        
        if let request = apiRequest {
            mainUi?.setCurrentItem(apiRequest!)
        }
        
    }
    
}

extension MainPresenter: MainUiCallbacks {

    func createNewRequest() -> APIRequest {
        apiRequest = APIRequest(method: METHODS[0], url: "")
        return apiRequest!
    }
    
    func addRequestParam(param: UrlParam) -> Void {
        if let request = apiRequest {
            request.urlParamList.append(param)
        }
    }
    
    func addHeaderParam(param: UrlParam) {
        if let request = apiRequest {
            request.headerList.append(param)
        }
    }
    
    func getUrlParam(atIndex index: Int) -> UrlParam? {
        if index < 0 {
            return nil
        }
        
        if index >= apiRequest!.urlParamList.count {
            return nil
        }
        
        return apiRequest!.urlParamList[index]
    }
    
    func saveCurrentRequest() -> APIRequest? {
        if let request = apiRequest, ui = mainUi{
            let url = ui.getUrlString().stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            if url.hasPrefix("http://") || url.hasPrefix("https://") {
                request.url = url
            } else {
                request.url = "http://" + url
            }
            request.method = mainUi!.getMethodString()
            request.lastRequestTime = NSDate()
            request.save()

            return request
        } else {
            return nil
        }

    }
    
    func isCurrentRequestValid() -> (valid: Bool, warningText: String?) {
        if let ui = mainUi {
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