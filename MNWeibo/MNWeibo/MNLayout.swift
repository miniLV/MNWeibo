//
//  MNLayout.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/22.
//  Copyright © 2020 miniLV. All rights reserved.
//

import UIKit

/**
/**常用属性，这里就不抽出去了*/
//屏幕宽高
#define ScreenH  [[UIScreen mainScreen] bounds].size.height
#define ScreenW  [[UIScreen mainScreen] bounds].size.width
//创建frame
#define Frame(x,y,width,height) CGRectMake(x, y, width, height)

//图片方法(直接字符串赋值)
#define MNImage(imgName)  [UIImage imageNamed:imgName]

// iPhone X
#define  LL_iPhoneX (ScreenW == 375.f && ScreenH == 812.f ? YES : NO)

// Status bar height.
#define  LL_StatusBarHeight      (LL_iPhoneX ? 44.f : 20.f)

// Tabbar height.
#define  DefaultBottomTabBarHeight         (LL_iPhoneX ? (49.f+34.f) : 49.f)

// Status bar & navigation bar height.
#define  DefaultNaviHeight  (LL_iPhoneX ? 88.f : 64.f)

///默认间距 - 15
#define DefaultMargin 15
#define DefaultCellHeight 44
*/

struct MNLayout {

    static let ratio:CGFloat = UIScreen.main.bounds.width / 375.0
    static func Layout(_ number: CGFloat) -> CGFloat {
        return number * ratio
    }
}

//struct MNScreen {
//    static let screenW:CGFloat = UIScreen.main.bounds.width
//    static let screenH:CGFloat = UIScreen.main.bounds.height
//}
