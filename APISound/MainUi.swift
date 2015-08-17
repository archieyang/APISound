//
//  MainUi.swift
//  APISound
//
//  Created by archie on 15/8/9.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import Foundation

public protocol MainUi: BaseUi {
    func setCurrentItem(apiRequest: APIRequest) -> Void
    func getUrlString() -> String
    func getMethodString() -> String
}