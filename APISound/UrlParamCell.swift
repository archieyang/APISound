//
//  UrlParamCell.swift
//  APISound
//
//  Created by archie on 15/5/26.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import UIKit

class UrlParamCell: UITableViewCell {
    
    @IBOutlet weak var paramKey: UITextField!
    @IBOutlet weak var paramValue: UITextField!
    
    var urlParam: UrlParam! {
        didSet {
            paramKey.text = urlParam.key
            paramValue.text = urlParam.value
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
