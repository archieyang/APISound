//
//  MethodPickerDelegate.swift
//  APISound
//
//  Created by archie on 15/6/10.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import UIKit

class MethodPickerDelegate: NSObject, UIPickerViewDelegate {
    unowned let mainViewController: MainViewController
    let pickedCallback: Int -> Void
    init(controller: MainViewController, callback: Int -> Void) {
        mainViewController = controller
        pickedCallback = callback
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return mainViewController.METHODS[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickedCallback(row)
    }
   
}
