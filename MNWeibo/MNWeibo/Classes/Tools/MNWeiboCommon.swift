//
//  MNWeiboCommon.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/17.
//  Copyright © 2020 miniLV. All rights reserved.
//

import Foundation

// MARK: - App infomation
let MNAppKey = "2845164143"

let MNAppSecret = "1d5722ce73b172632d7921b59d936e0a"
// 登录完成-跳转的地址
let MNredirectUri = "http://baidu.com"

//MARK: - global notification

let MNUserShouldLoginNotification = "MNUserShouldLoginNotification"

let MNUserLoginSuccessNotification = "MNUserLoginSuccessNotification"


//MARK: - 微博配图视图常亮
//内部间距
let MNStatusPictureOutterMargin = MNLayout.Layout(12)
//外部间距
let MNStatusPictureInnerMargin = MNLayout.Layout(12)

let MNPictureMaxPerLine:CGFloat = 3

//1.calculate width
let MNPictureViewWidth = MNScreen.screenW - (2 * MNStatusPictureOutterMargin)

let MNPictureItemWidth = (MNPictureViewWidth - (2 * MNStatusPictureInnerMargin)) / MNPictureMaxPerLine
