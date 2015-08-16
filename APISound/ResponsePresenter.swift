//
//  ResponsePresenter.swift
//  APISound
//
//  Created by archie on 15/8/10.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import Foundation

class ResponsePresenter: BasePresenter {
    var mResponseUi: ResponseUi?
    var mRequest: APIRequest
    
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
        HttpFetcher().execute(mRequest) { response in
            self.mResponseUi?.setLoadingIndicatorHidden(true)
            self.mResponseUi?.setResponse(response)
        }
    }
    
}