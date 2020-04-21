//
//  HMPhotoBrowserPhotos.h
//  HMPhotoBrowser
//
//  Created by 刘凡 on 16/3/13.
//  Copyright © 2016年 itcast. All rights reserved.
//

@import UIKit;

/// 浏览照片模型
@interface HMPhotoBrowserPhotos : NSObject

/// 选中照片索引
@property (nonatomic) NSInteger selectedIndex;
/// 照片 url 字符串数组
@property (nonatomic) NSArray<NSString *> *urls;
/// 父视图图像视图数组，便于交互转场
@property (nonatomic) NSArray<UIImageView *> *parentImageViews;

@end
