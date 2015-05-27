//
//  UrlParam.swift
//  APISound
//
//  Created by archie on 15/5/27.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import Foundation

class UrlParam {
    init(k: String, v: String){
        key = k
        value = v
    }
    var key: String
    var value: String
}