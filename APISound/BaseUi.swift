//
//  BaseUi.swift
//  APISound
//
//  Created by archie on 15/8/9.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import Foundation

public protocol BaseUi: class {
    func setUiCallbacks(callbacks: BaseUiCallbacks) -> Void;
}