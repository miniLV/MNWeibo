//
//  MNWeiboCommon.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/17.
//  Copyright © 2020 miniLV. All rights reserved.
//

import Foundation

// MARK: - App infomation
let MNAppKey = "2045436852"

let MNAppSecret = "df5dc1bd561b735f025c6b637a7c25bb"
// 登录完成-跳转的地址
let MNredirectUri = "https://www.sina.com"

//MARK: - global notification

let MNUserShouldLoginNotification = "MNUserShouldLoginNotification"

let MNUserLoginSuccessNotification = "MNUserLoginSuccessNotification"

/// 微博Cell浏览照片
/// @param urlString   urlString 字符串
/// @param photoIndex  照片索引
/// @param placeholder 占位图像
let MNWeiboCellBrowserPhotoNotification = "MNWeiboCellBrowserPhotoNotification"

let MNWeiboCellBrowserPhotoIndexKey = "MNWeiboCellBrowserPhotoIndexKey"
let MNWeiboCellBrowserPhotoURLsKeys = "MNWeiboCellBrowserPhotoURLsKeys"
let MNWeiboCellBrowserPhotoImageViewsKeys = "MNWeiboCellBrowserPhotoImageViewsKeys"

//MARK: - 微博配图视图常亮
let MNDefaultMargin = MNLayout.Layout(12)
//外部间距
let MNStatusPictureOutterMargin = MNLayout.Layout(12)
//内部间距
let MNStatusPictureInnerMargin = MNLayout.Layout(5)

let MNPictureMaxPerLine:CGFloat = 3

//1.calculate width
let MNPictureViewWidth = UIScreen.mn_screenW - (2 * MNStatusPictureOutterMargin)

let MNPictureItemWidth = (MNPictureViewWidth - (2 * MNStatusPictureInnerMargin)) / MNPictureMaxPerLine

// iPhone X
let MN_iPhoneX = (UIScreen.mn_screenW >= 375 && UIScreen.mn_screenH >= 812)

// Status bar height.
let MN_statusBarHeight:CGFloat = MN_iPhoneX ? 44 : 20

let MN_naviContentHeight:CGFloat = 44

let MN_bottomTabBarContentHeigth:CGFloat = 49

let MN_bottomTabBarSpeacing:CGFloat = MN_iPhoneX ? 34 : 0

// Tabbar height.
let MN_bottomTabBarHeight:CGFloat  =  MN_iPhoneX ? (MN_bottomTabBarContentHeigth + MN_bottomTabBarSpeacing) : MN_bottomTabBarContentHeigth

// Status bar & navigation bar height.
var MN_naviBarHeight:CGFloat = MN_statusBarHeight + MN_naviContentHeight
