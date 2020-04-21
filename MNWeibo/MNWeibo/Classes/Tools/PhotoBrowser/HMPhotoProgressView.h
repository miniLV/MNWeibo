//
//  HMPhotoProgressView.h
//  HMPhotoBrowser
//
//  Created by 刘凡 on 16/3/14.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 图像下载进度视图
@interface HMPhotoProgressView : UIView

/// 进度
@property(nonatomic) float progress;
/// 进度颜色
@property(nonatomic, nullable) UIColor *progressTintColor;
/// 底色
@property(nonatomic, nullable) UIColor *trackTintColor;
/// 边框颜色
@property(nonatomic, nullable) UIColor *borderTintColor;

@end
