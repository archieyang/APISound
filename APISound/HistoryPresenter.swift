//
//  HistoryPresenter.swift
//  APISound
//
//  Created by archie on 15/8/9.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import Foundation

class HistoryPresenter: BasePresenter {

    override func populateUi() -> Void {
        APIRequestManager.sharedInstance.fetchAll { apiRequests in
            if let ui = self.mUi as? HistoryUi {
                ui.setItems(apiRequests)
            }
        }
        
    }
}
