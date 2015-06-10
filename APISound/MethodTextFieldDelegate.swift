//
//  MethodTextField.swift
//  APISound
//
//  Created by archie on 15/6/10.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import UIKit

class MethodTextFieldDelegate: NSObject, UITextFieldDelegate {
    let shouldBeginEditingCallback: () -> Bool
    
    init(textFieldShouldBeginEditingCallback: () -> Bool) {
        shouldBeginEditingCallback = textFieldShouldBeginEditingCallback
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return shouldBeginEditingCallback()
    }
}
