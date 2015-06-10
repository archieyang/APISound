//
//  MethodPickerDataSource.swift
//  APISound
//
//  Created by archie on 15/6/10.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import UIKit

class MethodPickerDataSource: NSObject, UIPickerViewDataSource {
    unowned let mainViewController: MainViewController
    
    init(controller: MainViewController) {
        mainViewController = controller
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return mainViewController.METHODS.count
    }
}
