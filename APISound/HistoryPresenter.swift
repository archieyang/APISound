//
//  HistoryPresenter.swift
//  APISound
//
//  Created by archie on 15/8/9.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import Foundation

class HistoryPresenter {
    private var mHistoryUi: HistoryUi!
    
    internal init() {
        
    }
    
    func attachUi(ui: HistoryUi) -> Void {
        mHistoryUi = ui
        populateUi()
    }
    
    private func populateUi() -> Void {
        APIRequestManager.sharedInstance.fetchAll { apiRequests in
            self.mHistoryUi.setItems(apiRequests)
        }
        
    }
}
