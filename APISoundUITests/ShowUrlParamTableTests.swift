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
        tapAddUrlParamButton()
        assertAddUrlParamsDialogOnView()
        fillKeyTextField()
    }
    
}

private extension ShowUrlParamTableTest {
    func tapUrlParamButton() {
        tester.tapViewWithAccessibilityLabel("URL Params", traits: UIAccessibilityTraitButton)
    }
    
    func assertAddUrlParamButtonOnView() {
        tester.waitForViewWithAccessibilityLabel("add URL Params")
    }
    
    func tapAddUrlParamButton() {
        tester.tapViewWithAccessibilityLabel("add URL Params", traits: UIAccessibilityTraitButton)
    }
    
    func assertAddUrlParamsDialogOnView() {
//        
//       tester.waitForViewWithAccessibilityLabel("OK").isUserInteractionActuallyEnabled()
    }
    
    func fillKeyTextField() {
        tester.enterText("start", intoViewWithAccessibilityLabel: "URL param key")
        tester.clearTextFromViewWithAccessibilityLabel("URL param value")
    }
    
    func assertDialogOKDisabled() {
//        tester.waitForViewWithAccessibilityLabel("Add URL Params OK")
    }
}