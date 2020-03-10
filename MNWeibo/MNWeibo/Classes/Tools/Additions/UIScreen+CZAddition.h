//
//  UIScreen+CZAddition.h
//
//  Created by 刘凡 on 16/5/17.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScreen (CZAddition)

/// 屏幕宽度
+ (CGFloat)cz_screenWidth;
/// 屏幕高度
+ (CGFloat)cz_screenHeight;
/// 分辨率
+ (CGFloat)cz_scale;

@end
