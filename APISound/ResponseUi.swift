//
//  ResponseUi.swift
//  APISound
//
//  Created by archie on 15/8/10.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import Foundation

public protocol ResponseUi: BaseUi {
    func setLoadingIndicatorHidden(hidden: Bool) -> Void
    func setMainText(text: String) -> Void
    func setStatusLine(statusLine: String) -> Void
    func setNoResponseHintHidden(hidden: Bool) -> Void
    func setStatusLineHidden(hidden: Bool) -> Void
}