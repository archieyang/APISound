//
//  UrlParamCell.swift
//  APISound
//
//  Created by archie on 15/5/26.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import UIKit

class UrlParamCell: UITableViewCell, UITextFieldDelegate{
    
    @IBOutlet weak var paramKey: UITextField!
    @IBOutlet weak var paramValue: UITextField!
    
    var urlParam: UrlParam! {
        didSet {
            paramKey.text = urlParam.key
            paramValue.text = urlParam.value
            paramKey.delegate = self
            paramValue.delegate = self
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        urlParam.key = paramKey.text
        urlParam.value = paramValue.text
    }

}
