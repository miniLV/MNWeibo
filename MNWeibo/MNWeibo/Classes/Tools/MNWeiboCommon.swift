//
//  MNWeiboCommon.swift
//  MNWeibo
//
//  Created by miniLV on 2020/3/17.
//  Copyright © 2020 miniLV. All rights reserved.
//

import Foundation

// MARK: - App infomation
let MNAppKey = "439197239"

let MNAppSecret = "cc940f502b0d95c7121a15dd4fe41e15"
// 登录完成-跳转的地址
let MNredirectUri = "http://baidu.com"

//MARK: - global notification

let MNUserShouldLoginNotification = "MNUserShouldLoginNotification"

let MNUserLoginSuccessNotification = "MNUserLoginSuccessNotification"


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
