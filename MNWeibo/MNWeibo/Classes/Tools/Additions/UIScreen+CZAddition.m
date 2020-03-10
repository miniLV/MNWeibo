//
//  UIScreen+CZAddition.m
//
//  Created by 刘凡 on 16/5/17.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "UIScreen+CZAddition.h"

@implementation UIScreen (CZAddition)

+ (CGFloat)cz_screenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)cz_screenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}

+ (CGFloat)cz_scale {
    return [UIScreen mainScreen].scale;
}

@end
