//
//  ResponsePresenterSpec.swift
//  APISound
//
//  Created by archie on 15/8/22.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import Foundation
import Quick
import Nimble
import APISound

class ResponsePresenterSpec: QuickSpec {
    override func spec() {
        
        class FetcherStub: Fetcher {
            let mResponse: Response
            var mRequest: APIRequest?
            
            init(response: Response) {
                mResponse = response
            }
            
            func execute(request: APIRequest, callback: (Response?) -> Void) {
                mRequest = request
                callback(mResponse)
            }
        }
        
        class ResponseUiStub: ResponseUi {
            var mMainText: String?
            var mStatusLine: String?
            var mLoadingIndicatorHidden: Bool?
            var mResponseUiCallbacks: ResponseUiCallbacks?
            var mIsNoResponseHintHidden = true
            var mIsStatusLineHidden = false
            
            func setMainText(text: String) {
                mMainText = text
            }
            
            func setNoResponseHintHidden(hidden: Bool) {
                mIsNoResponseHintHidden = hidden
            }
            
            func setStatusLine(statusLine: String) {
                mStatusLine = statusLine
            }
            
            func setLoadingIndicatorHidden(hidden: Bool) {
                mLoadingIndicatorHidden = hidden
            }
            
            func setStatusLineHidden(hidden: Bool) {
                mIsStatusLineHidden = hidden
            }
            
            func setUiCallbacks(callbacks: BaseUiCallbacks) -> Void {
                mResponseUiCallbacks = callbacks as? ResponseUiCallbacks
            }
        }
        
        class ResponseStub: Response {
            func getBody() -> String? {
                return "Body"
            }
            func getStatusLine() -> String? {
                return "StatusLine"
            }
            func getFormattedHeader() -> String? {
                return "Formatted Headers"
            }
        }
        
        var request: APIRequest!
        var ui: ResponseUiStub!
        
        
        beforeEach {
            request = APIRequest(method: "GET", url: "codethink.me")
            ui = ResponseUiStub()
        }
        
        describe("populateUi") {
            context("Set callbacks") {

                it("sets ResponseUiCallback, status line and body, hides the loading indicator and leaves headers to be nil") {
                    let presenter = ResponsePresenter(apiRequest: request, fetcher: FetcherStub(response: ResponseStub()))
                    
                    presenter.attachUi(ui)
                    
                    expect(ui.mLoadingIndicatorHidden).to(beTrue())
                    expect(ui.mResponseUiCallbacks).notTo(beNil())
                    expect(ui.mStatusLine).to(equal("StatusLine"))
                    expect(ui.mMainText).to(equal("Body"))
                    expect(ui.mIsNoResponseHintHidden).to(beTrue())
                    expect(ui.mIsStatusLineHidden).to(beFalse())
                }
            }
        }
        
        describe("switch between headers and body") {
            context("with non-empty response") {
                
                beforeEach {
                    let presenter = ResponsePresenter(apiRequest: request, fetcher: FetcherStub(response: ResponseStub()))
                    presenter.attachUi(ui)
                }
                
                it("switch to headers") {
                    
                    ui.mResponseUiCallbacks?.onShowHeaders()
                    
                    expect(ui.mMainText).to(equal("Formatted Headers"))
                    expect(ui.mIsNoResponseHintHidden).to(beTrue())
                    expect(ui.mIsStatusLineHidden).to(beFalse())
                    
                }
                
                it("switch to body") {
                    ui.mResponseUiCallbacks?.onShowBody()
                    
                    expect(ui.mMainText).to(equal("Body"))
                    expect(ui.mIsNoResponseHintHidden).to(beTrue())
                    expect(ui.mIsStatusLineHidden).to(beFalse())
                }
            }
            
            
            context("with empty response") {
                class EmptyResponseStub: Response {
                    func getBody() -> String? {
                        return nil
                    }
                    
                    func getFormattedHeader() -> String? {
                        return nil
                    }
                    
                    func getStatusLine() -> String? {
                        return nil
                    }
                }
                
                beforeEach {
                    let presenter = ResponsePresenter(apiRequest: request, fetcher: FetcherStub(response: EmptyResponseStub()))
                    presenter.attachUi(ui)
                }
                
                it("hides status line") {
                    expect(ui.mIsStatusLineHidden).to(beTrue())
                }
                
                it("switch to headers") {
                    ui.mResponseUiCallbacks?.onShowHeaders()
                    
                    expect(ui.mMainText).to(beNil())
                    expect(ui.mIsNoResponseHintHidden).to(beFalse())
                }
                
                it("switch to headers") {
                    ui.mResponseUiCallbacks?.onShowBody()
                    
                    expect(ui.mMainText).to(beNil())
                    expect(ui.mIsNoResponseHintHidden).to(beFalse())
                }
            }
            
        }
        
        
        
    }
}
