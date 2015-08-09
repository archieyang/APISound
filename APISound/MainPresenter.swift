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
    
    override func onAttachToUi() {
        mUi.setUiCallbacks(self)
    }
    
    override func populateUi() {
        if let request = apiRequest {
            
        } else {
            apiRequest = APIRequest(method: METHODS[0], url: "")
        }
        
        if let request = apiRequest {
            if let ui = self.mUi as? MainUi {
                ui.setCurrentItem(apiRequest!)
            }
        }
        
    }
    
}

extension MainPresenter: MainUiCallbacks {

    func createNewRequest() -> APIRequest {
        apiRequest = APIRequest(method: METHODS[0], url: "")
        return apiRequest!
    }
}

protocol MainUiCallbacks: BaseUiCallbacks {
    func createNewRequest() -> APIRequest
}