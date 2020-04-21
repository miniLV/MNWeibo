//
//  HMPhotoViewerController.h
//  HMPhotoBrowser
//
//  Created by 刘凡 on 16/3/13.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 单张照片查看控制器 - 显示单张照片使用
@interface HMPhotoViewerController : UIViewController

/// 实例化单图查看器
///
/// @param urlString   urlString 字符串
/// @param photoIndex  照片索引
/// @param placeholder 占位图像
///
/// @return 单图查看器
+ (nonnull instancetype)viewerWithURLString:(NSString * _Nonnull)urlString photoIndex:(NSInteger)photoIndex placeholder:(UIImage * _Nonnull)placeholder;

@property (nonatomic) NSInteger photoIndex;

@property (nonatomic, readonly, nonnull) UIScrollView *scrollView;
@property (nonatomic, readonly, nonnull) UIImageView *imageView;

@end
