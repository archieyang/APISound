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
        assertAddUrlParamButtonOnView()
    }
    
}

private extension ShowUrlParamTableTest {
    func tapUrlParamButton() {
        tester.tapViewWithAccessibilityLabel("URL Params",traits: UIAccessibilityTraitButton)
    }
    
    func assertAddUrlParamButtonOnView() {
        tester.waitForViewWithAccessibilityLabel("add URL Params")
    }
}