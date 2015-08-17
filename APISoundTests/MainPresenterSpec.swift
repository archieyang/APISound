//
//  MainPresenterSpec.swift
//  APISound
//
//  Created by archie on 15/8/17.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import Foundation
import Quick
import Nimble
import APISound

class MainPresenterSpec: QuickSpec {
    class MockMainUi: MainUi {
        var mApiRequest: APIRequest!
        var mCallbacks: MainUiCallbacks!
        
        func setUiCallbacks(callbacks: BaseUiCallbacks) -> Void {
            if let mainUiCallbacks = callbacks as? MainUiCallbacks {
                mCallbacks = mainUiCallbacks
            }
        }
        
        func setCurrentItem(request: APIRequest) -> Void{
            mApiRequest = request
        }
        
        func getMethodString() -> String {
            return "POST"
        }
        
        func getUrlString() -> String {
            return "http://hi"
        }
        
    }
    override func spec() {
        var mainPresenter = MainPresenter()
        
        describe(".createNewRequest") {
            context("Request created successfully") {
                it("return the same request passed in") {
                    let fakeRequest: APIRequest = APIRequest(method: "PGET", url: "http://codethink.me")
                    
                    let newRequest = mainPresenter.createNewRequest(fakeRequest)
                    
                    expect(newRequest === fakeRequest).to(beTrue())
                    
                }
            }
            
        }
    }
}