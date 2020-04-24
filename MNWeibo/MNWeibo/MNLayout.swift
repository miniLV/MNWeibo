//
//  MNLayout.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/22.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

struct MNLayout {

    static let ratio:CGFloat = UIScreen.main.bounds.width / 375.0
    static func Layout(_ number: CGFloat) -> CGFloat {
        return number * ratio
    }
}

