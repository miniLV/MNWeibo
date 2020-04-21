//
//  HMPhotoBrowserAnimator.m
//  HMPhotoBrowser
//
//  Created by 刘凡 on 16/3/13.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HMPhotoBrowserAnimator.h"
#import "HMPhotoBrowserPhotos.h"
#import "SDWebImageManager.h"
#import <SDWebImage/SDWebImage.h>

@interface HMPhotoBrowserAnimator() <UIViewControllerAnimatedTransitioning>

@end

@implementation HMPhotoBrowserAnimator {
    BOOL _isPresenting;
    HMPhotoBrowserPhotos *_photos;
}

#pragma mark - 构造函数
+ (instancetype)animatorWithPhotos:(HMPhotoBrowserPhotos *)photos {
    return [[self alloc] initWithPhotos:photos];
}

- (instancetype)initWithPhotos:(HMPhotoBrowserPhotos *)photos {
    self = [super init];
    if (self) {
        _photos = photos;
    }
    return self;
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    _isPresenting = YES;
    
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    _isPresenting = NO;
    
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    _isPresenting ? [self presentTransition:transitionContext] : [self dismissTransition:transitionContext];
}

#pragma mark - 展现转场动画方法
- (void)presentTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *containerView = [transitionContext containerView];
    
    UIImageView *dummyIV = [self dummyImageView];
    UIImageView *parentIV = [self parentImageView];
    dummyIV.frame = [containerView convertRect:parentIV.frame fromView:parentIV.superview];
    [containerView addSubview:dummyIV];
    
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    [containerView addSubview:toView];
    toView.alpha = 0.0;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        dummyIV.frame = [self presentRectWithImageView:dummyIV];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            toView.alpha = 1.0;
        } completion:^(BOOL finished) {
            [dummyIV removeFromSuperview];
            
            [transitionContext completeTransition:YES];
        }];
    }];
}

/// 根据图像计算展现目标尺寸
- (CGRect)presentRectWithImageView:(UIImageView *)imageView {
    UIImage *image = imageView.image;
    
    if (image == nil) {
        return imageView.frame;
    }
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGSize imageSize = screenSize;
    
    imageSize.height = image.size.height * imageSize.width / image.size.width;
    
    CGRect rect = CGRectMake(0, 0, imageSize.width, imageSize.height);
    
    if (imageSize.height < screenSize.height) {
        rect.origin.y = (screenSize.height - imageSize.height) * 0.5;
    }
    
    return rect;
}

/// 生成 dummy 图像视图
- (UIImageView *)dummyImageView {
    UIImageView *iv = [[UIImageView alloc] initWithImage:[self dummyImage]];
    
    iv.contentMode = UIViewContentModeScaleAspectFill;
    iv.clipsToBounds = YES;
    
    return iv;
}

/// 生成 dummy 图像
- (UIImage *)dummyImage {
  
    NSString *key = _photos.urls[_photos.selectedIndex];
    UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:key];
    
    if (image == nil) {
        image = _photos.parentImageViews[_photos.selectedIndex].image;
    }
    return image;
}

/// 父视图参考图像视图
- (UIImageView *)parentImageView {
    return _photos.parentImageViews[_photos.selectedIndex];
}

#pragma mark - 解除转场动画方法
- (void)dismissTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *containerView = [transitionContext containerView];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    UIImageView *dummyIV = [self dummyImageView];
    dummyIV.frame = [containerView convertRect:_fromImageView.frame fromView:_fromImageView.superview];
    dummyIV.alpha = fromView.alpha;
    [containerView addSubview:dummyIV];
    
    [fromView removeFromSuperview];
    
    UIImageView *parentIV = [self parentImageView];
    CGRect targetRect = [containerView convertRect:parentIV.frame fromView:parentIV.superview];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        dummyIV.frame = targetRect;
        dummyIV.alpha = 1.0;
    } completion:^(BOOL finished) {
        [dummyIV removeFromSuperview];
        
        [transitionContext completeTransition:YES];
    }];
}

@end
