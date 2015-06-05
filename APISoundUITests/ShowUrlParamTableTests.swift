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
        tapAddUrlParamButton()
        assertAddUrlParamsDialogOnView()
        
        fillKeyTextField()
        tapDoneButton()
        assertAddUrlParamsDialogOnView()
        
        fillKeyAndValueTextField()
        tapDoneButton()
        assertAddUrlParamsDialogOffView()
    }
    
}

private extension ShowUrlParamTableTest {
    
    func tapAddUrlParamButton() {
        tester.tapViewWithAccessibilityLabel("Add URL Params", traits: UIAccessibilityTraitButton)
    }
    
    func assertAddUrlParamsDialogOnView() {
        assert(tester.tryFindingViewWithAccessibilityLabel("Add parameters", error: nil))
    }
    func assertAddUrlParamsDialogOffView() {
        assert(!tester.tryFindingViewWithAccessibilityLabel("Add parameters", error: nil))
    }
    
    func fillKeyTextField() {
        tester.clearTextFromViewWithAccessibilityLabel("URL param key")
        tester.clearTextFromViewWithAccessibilityLabel("URL param value")
        tester.enterText("start", intoViewWithAccessibilityLabel: "URL param key")
        tester.clearTextFromViewWithAccessibilityLabel("URL param value")
    }
    
    func tapDoneButton() {
        tester.tapViewWithAccessibilityLabel("Done")
    }
    
    func fillKeyAndValueTextField() {
        tester.clearTextFromViewWithAccessibilityLabel("URL param key")
        tester.clearTextFromViewWithAccessibilityLabel("URL param value")
        tester.enterText("start", intoViewWithAccessibilityLabel: "URL param key")
        tester.enterText("3", intoViewWithAccessibilityLabel: "URL param value")
        
    }
}