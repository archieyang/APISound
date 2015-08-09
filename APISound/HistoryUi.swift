//
//  HistoryUi.swift
//  APISound
//
//  Created by archie on 15/8/8.
//  Copyright (c) 2015年 archie. All rights reserved.
//

import Foundation
protocol HistoryUi {
    func setItems(items: [APIRequest]) -> Void
}