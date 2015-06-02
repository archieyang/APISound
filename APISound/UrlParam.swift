//
//  UrlParam.swift
//  APISound
//
//  Created by archie on 15/5/27.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import Foundation

public struct UrlParam {
    public init(k: String, v: String){
        key = k
        value = v
    }
    public let key: String
    public let value: String
}