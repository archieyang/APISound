//
//  ResponsePresenter.swift
//  APISound
//
//  Created by archie on 15/8/10.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import Foundation

class ResponsePresenter: BasePresenter {
    var responseUi: ResponseUi?
    var request: APIRequest
    
    init(apiRequest: APIRequest) {
        request = apiRequest
    }
    
    override var mUi: BaseUi! {
        didSet {
            if let ui = mUi as? ResponseUi {
                responseUi = ui
            }
        }
    }
    
    override func populateUi() {
        self.responseUi?.setLoadingIndicatorHidden(false)
        HttpFetcher().execute(request) { response in
            self.responseUi?.setLoadingIndicatorHidden(true)
            self.responseUi?.setResponse(response)
        }
    }
    
}