//
//  HistoryPresenterSpec.swift
//  APISound
//
//  Created by archie on 15/8/20.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import Foundation
import Quick
import Nimble
import APISound

class HistoryPresenterSpec: QuickSpec {
    override func spec() {
        var presenter: HistoryPresenter!
        
        var historyUi: HistoryUiStub!
        
        beforeEach {
            historyUi = HistoryUiStub()
        }
        
        
        describe("set data to UI") {
            context("No data") {
                it("return empty item and group list") {
                    class ZeroItemRequestManager: RequestManager {
                        func fetchAll(callback: ([APIRequest]) -> Void) {
                            callback([APIRequest]())
                        }
                    }
                    
                    presenter = HistoryPresenter(requestManager: ZeroItemRequestManager())
                    presenter.attachUi(historyUi)
                    
                    expect(historyUi.mItems.count).to(equal(0))
                    expect(historyUi.mGroupItems.count).to(equal(0))
                }
            }
            
            context("3 items in 1 group") {
                it("set the right items and groups") {
                    let numOfItem = 3
                    
                    class ThreeItemRequestManager: RequestManager {
                        
                        private let mApiRequests: [APIRequest]!
                        
                        init(numOfItem: Int) {
                            mApiRequests = [APIRequest]()
                            for i in 0..<numOfItem {
                                mApiRequests.append(APIRequest(method: "POST", url: "url \(i)"))
                            }
                            
                        }
                        
                        func fetchAll(callback: ([APIRequest]) -> Void) {
                            callback(mApiRequests)
                        }
                    }
                    
                    presenter = HistoryPresenter(requestManager: ThreeItemRequestManager(numOfItem: numOfItem))
                    presenter.attachUi(historyUi)
                    expect(historyUi.mItems.count).to(equal(numOfItem))
                    expect(historyUi.mGroupItems.count).to(equal(1))
                }
            }
        }
        
        class HistoryUiStub: HistoryUi {
            var mItems: [APIRequest]!
            var mGroupItems: [HistorySectionItem]!
            
            func setItems(items: [APIRequest]) {
                mItems = items
            }
            
            func setGroups(groupItems: [HistorySectionItem]) {
                mGroupItems = groupItems
            }
            
            
            func setUiCallbacks(callbacks: BaseUiCallbacks) {
            
            }
            
        }
        
    }
}
