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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        paramKey.delegate = self
        paramValue.delegate = self
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        urlParam.key = paramKey.text
        urlParam.value = paramValue.text
    }

}
