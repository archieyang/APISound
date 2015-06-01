//
//  ShowUrlParamTableTests.swift
//  APISound
//
//  Created by archie on 15/6/1.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import Foundation
import XCTest

class ShowUrlParamTableTest: XCTestCase {
    func testShowUrlParamTable() {
        tapUrlParamButton()
//        assertUrlParamTableOnView()
    }
    
}

private extension ShowUrlParamTableTest {
    func tapUrlParamButton() {
        tester.tapViewWithAccessibilityLabel("URL Params",traits: UIAccessibilityTraitButton)
    }
    
//    func assertUrlParamTableOnView() {
//        assert(UIApplication.sharedApplication().accessibilityElementWithLabel("URL Params", accessibilityValue: "URL Params", traits: UIAccessibilityTraitButton) != nil)
//    }
}