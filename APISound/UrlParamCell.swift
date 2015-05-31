//
//  UrlParamCell.swift
//  APISound
//
//  Created by archie on 15/5/26.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import UIKit

class UrlParamCell: UITableViewCell{
    
    @IBOutlet weak var paramKeyLabel: UILabel!
    @IBOutlet weak var paramValueLabel: UILabel!

    
    var urlParam: UrlParam! {
        didSet {
            paramKeyLabel.text = urlParam.key
            paramValueLabel.text = urlParam.value
        }
    }

}
