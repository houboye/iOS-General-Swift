//
//  DemoItem.swift
//  BYGeneralSwift
//
//  Created by boye on 2021/12/10.
//

import UIKit

enum DemoType {
    case offScreenRendering
    case VPN
}

struct DemoItem {
    var title: String
    var demoType: DemoType
}
