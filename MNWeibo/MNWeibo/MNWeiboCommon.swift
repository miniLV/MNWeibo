//
//  MNWeiboCommon.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/17.
//  Copyright © 2020 miniLV. All rights reserved.
//

import Foundation

// MARK: - App infomation
let MNAppKey = "2300355184"

let MNAppSecret = "98c2feb9cca32e00b796e3cf372270a7"
// 登录完成-跳转的地址
let MNredirectUri = "http://baidu.com"

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
let MNPictureViewWidth = MNScreen.screenW - (2 * MNStatusPictureOutterMargin)

let MNPictureItemWidth = (MNPictureViewWidth - (2 * MNStatusPictureInnerMargin)) / MNPictureMaxPerLine
