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
    override func spec() {
        var mainPresenter: MainPresenter!
        var request: APIRequest!
        
        class MockMainUi: MainUi {
            var mApiRequest: APIRequest!
            var mCallbacks: MainUiCallbacks!
            
            let mMethod: String
            let mUrl: String
            
            init(url: String, method: String) {
                mUrl = url
                mMethod = method
            }
            
            func setUiCallbacks(callbacks: BaseUiCallbacks) -> Void {
                if let mainUiCallbacks = callbacks as? MainUiCallbacks {
                    mCallbacks = mainUiCallbacks
                }
            }
            
            func setCurrentItem(request: APIRequest) -> Void{
                mApiRequest = request
            }
            
            func getMethodString() -> String {
                return mMethod
            }
            
            func getUrlString() -> String {
                return mUrl
            }
            
        }
        
        beforeEach {
            mainPresenter = MainPresenter()
            
            request = mainPresenter.createNewRequest(APIRequest(method: "PGET", url: "http://codethink.me"))
            
        }
        
        describe(".createNewRequest") {
            context("Request created successfully") {
                it("return the same request passed in") {
                    let fakeRequest: APIRequest = APIRequest(method: "PGET", url: "http://codethink.me")
                    
                    let newRequest = mainPresenter.createNewRequest(fakeRequest)
                    
                    expect(newRequest === fakeRequest).to(beTrue())
                    
                }
            }
            
        }
        
        describe(".addHeaderParam") {
            context("Header added successfully") {
                it("receives the header passed in") {
                    let param = UrlParam(k: "header_key", v: "header_value")
                    mainPresenter.addHeaderParam(param)
                    
                    expect(request.mHeaderList.count).to(equal(1))
                    expect(request.mHeaderList[0]).to(equal(param))
                }
            }
        }
        
        describe(".addRequestParam") {
            context("Request parameter added successfully") {
                it("receives the header passed in") {
                    let param = UrlParam(k: "param_key", v: "param_value")
                    mainPresenter.addRequestParam(param)
                    
                    expect(request.mUrlParamList.count).to(equal(1))
                    expect(request.mUrlParamList[0]).to(equal(param))
                    
                }
            }
        }

        describe(".saveCurrentRequest") {
            
            context("Normal case") {
                it("saved successfully") {
                    let ui = MockMainUi(url: "http://codethink.me", method: "GET")
                    mainPresenter.attachUi(ui)
                    let savedRequest = mainPresenter.saveCurrentRequest()!
                    
                    expect(savedRequest.mMethod).to(equal(ui.getMethodString()))
                    expect(savedRequest.mUrl).to(equal(ui.getUrlString()))
                }
            }
            context("Request does not have scheme") {
                it("adds 'http://' automatically") {
                    let ui = MockMainUi(url: "codethink.me", method: "GET")
                    mainPresenter.attachUi(ui)
                    let savedRequest = mainPresenter.saveCurrentRequest()!
                    
                    expect(request.mMethod).to(equal("GET"))
                    expect(request.mUrl).to(equal("http://codethink.me"))
                }
            }
            
            context("URL has spaces") {
                it("trim spaces") {
                    let ui = MockMainUi(url: "  http://codethink.me  ", method: "GET")
                    mainPresenter.attachUi(ui)
                    let savedRequest = mainPresenter.saveCurrentRequest()!
                    
                    expect(request.mMethod).to(equal("GET"))
                    expect(request.mUrl).to(equal("http://codethink.me"))
                }
            }
            
        }
        
        describe(".isCurrentRequestValid") {
            context("Normal case") {
                it("returns true") {
                    let ui = MockMainUi(url: "http://codethink.me", method: "GET")
                    mainPresenter.attachUi(ui)
                    
                    expect(mainPresenter.isCurrentRequestValid().valid).to(beTrue())
                    expect(mainPresenter.isCurrentRequestValid().warningText).to(beNil())
                }
            }
            
            context("Empty URL") {
                it("returns false and error message") {
                    let ui = MockMainUi(url: "", method: "GET")
                    mainPresenter.attachUi(ui)
                    
                    expect(mainPresenter.isCurrentRequestValid().valid).to(beFalse())
                    expect(mainPresenter.isCurrentRequestValid().warningText!).to(equal("URL should not be empty"))
                }
            }
            
            context("Space in URL field") {
                it("returns false and error message") {
                    let ui = MockMainUi(url: "   ", method: "GET")
                    mainPresenter.attachUi(ui)
                    
                    expect(mainPresenter.isCurrentRequestValid().valid).to(beFalse())
                    expect(mainPresenter.isCurrentRequestValid().warningText!).to(equal("URL should not be empty"))
                }
            }
        }
    }
}