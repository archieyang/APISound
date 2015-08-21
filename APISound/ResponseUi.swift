//
//  ResponseUi.swift
//  APISound
//
//  Created by archie on 15/8/10.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import Foundation

protocol ResponseUi: BaseUi {
    func setLoadingIndicatorHidden(hidden: Bool) -> Void
    func setHeaders(formattedHeaders: String?) -> Void
    func setBody(body: String?) -> Void
    func setStatusLine(statusLine: String?) -> Void
}