//
//  UrlParam.swift
//  APISound
//
//  Created by archie on 15/5/27.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import Foundation

public struct UrlParam: Equatable {
    public init(k: String, v: String){
        key = k
        value = v
    }
    public let key: String
    public let value: String
}

public func ==(lhs: UrlParam, rhs: UrlParam) -> Bool {
    return lhs.key == rhs.key && lhs.value == rhs.value
}

