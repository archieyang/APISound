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
        
        assertUrlParamInTableView()
        
        
        tapCellOne()
        assertEditUrlParamsDialogOnView()
    }
    
}

private extension ShowUrlParamTableTest {
    
    enum ButtonLabel: String {
        case AddUrlParams = "Add URL Params"
    }
    
    enum AddUrlParamAlert: String {
        case Title = "Add parameters"
        case KeyTextField = "URL param key"
        case ValueTextField = "URL param value"
        case DoneButton = "Done"
        case CancelButton = "Cancel"
    }
    enum EditUrlParamAlert: String {
        case Title = "Edit parameters"
        case KeyTextField = "URL param key"
        case ValueTextField = "URL param value"
        case DoneButton = "Done"
        case CancelButton = "Cancel"
    }
    
    enum UrlParamTable: String {
        case CellOne = "URL Param 0"
        case KeyLabel = "URL Param Key 0"
        case ValueLabel = "URL Param Value 0"
    }
    
    enum MockUrlParam: String {
        case Key = "start"
        case Value = "3"
    }

    func tapAddUrlParamButton() {
        tester.tapViewWithAccessibilityLabel(ButtonLabel.AddUrlParams.rawValue, traits: UIAccessibilityTraitButton)
    }
    
    func assertAddUrlParamsDialogOnView() {
        XCTAssertTrue(tester.tryFindingViewWithAccessibilityLabel(AddUrlParamAlert.Title.rawValue, error: nil), "Add Url Param dialog not shown")
    }
    func assertAddUrlParamsDialogOffView() {
        XCTAssertFalse(tester.tryFindingViewWithAccessibilityLabel(AddUrlParamAlert.Title.rawValue, error: nil),
        "Add Url Param dialog not hidden")
    }
    
    func fillKeyTextField() {
        tester.clearTextFromViewWithAccessibilityLabel(AddUrlParamAlert.KeyTextField.rawValue)
        tester.clearTextFromViewWithAccessibilityLabel(AddUrlParamAlert.ValueTextField.rawValue)
        tester.enterText(MockUrlParam.Key.rawValue, intoViewWithAccessibilityLabel: AddUrlParamAlert.KeyTextField.rawValue)
        tester.clearTextFromViewWithAccessibilityLabel(AddUrlParamAlert.ValueTextField.rawValue)
    }
    
    func tapDoneButton() {
        tester.tapViewWithAccessibilityLabel(AddUrlParamAlert.DoneButton.rawValue)
    }
    
    func fillKeyAndValueTextField() {
        tester.clearTextFromViewWithAccessibilityLabel(AddUrlParamAlert.KeyTextField.rawValue)
        tester.clearTextFromViewWithAccessibilityLabel(AddUrlParamAlert.ValueTextField.rawValue)
        tester.enterText(MockUrlParam.Key.rawValue, intoViewWithAccessibilityLabel: AddUrlParamAlert.KeyTextField.rawValue)
        tester.enterText(MockUrlParam.Value.rawValue, intoViewWithAccessibilityLabel: AddUrlParamAlert.ValueTextField.rawValue)
        
    }
    
    func assertUrlParamInTableView() {
        tester.waitForViewWithAccessibilityLabel(UrlParamTable.CellOne.rawValue)
       
        XCTAssertEqual((tester.waitForViewWithAccessibilityLabel(UrlParamTable.KeyLabel.rawValue) as! UILabel).text!, MockUrlParam.Key.rawValue, "Key in TableView Not Shown")
        XCTAssertEqual((tester.waitForViewWithAccessibilityLabel(UrlParamTable.ValueLabel.rawValue) as! UILabel).text!, MockUrlParam.Value.rawValue, "Value in TableView Not Shown")
    }
    
    func tapCellOne() {
        tester.tapViewWithAccessibilityLabel(UrlParamTable.CellOne.rawValue)
    }
    
    func assertEditUrlParamsDialogOnView() {
        XCTAssertTrue(tester.tryFindingViewWithAccessibilityLabel(EditUrlParamAlert.Title.rawValue, error: nil), "Edit dialog not shown")
    }
}