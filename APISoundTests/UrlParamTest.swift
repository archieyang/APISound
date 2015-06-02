//
//  UrlParamTest.swift
//  APISound
//
//  Created by archie on 15/6/2.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import APISound
import Quick
import Nimble

class UrlParamTest: QuickSpec {
    override func spec() {
        describe("URL params") {
            var urlParam: UrlParam!
            beforeEach {
                urlParam = UrlParam(k: "key", v: "value")
            }
            
            it("has a key") {
                expect(urlParam.key).to(equal("key"))
            }
            
            it("has a value") {
                expect(urlParam.value).to(equal("value"))
            }
        }
    }

}
