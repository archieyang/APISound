//
//  ResponseUi.swift
//  APISound
//
//  Created by archie on 15/8/10.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import Foundation

protocol ResponseUi: BaseUi {
    func setResponse(response: APIResponse?) -> Void
    func setLoadingIndicatorHidden(hidden: Bool) -> Void
}