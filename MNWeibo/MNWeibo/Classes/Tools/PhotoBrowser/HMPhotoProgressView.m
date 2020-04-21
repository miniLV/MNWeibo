//
//  HMPhotoProgressView.m
//  HMPhotoBrowser
//
//  Created by 刘凡 on 16/3/14.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HMPhotoProgressView.h"

@implementation HMPhotoProgressView

#pragma mark - 构造函数
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self != nil) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark - setter & getter 方法
- (void)setProgress:(float)progress {
    _progress = progress;
    
    [self setNeedsDisplay];
}

- (UIColor *)trackTintColor {
    if (_trackTintColor == nil) {
        _trackTintColor = [UIColor colorWithWhite:0.0 alpha:0.6];
    }
    return _trackTintColor;
}

- (UIColor *)progressTintColor {
    if (_progressTintColor == nil) {
        _progressTintColor = [UIColor colorWithWhite:0.8 alpha:0.8];
    }
    return _progressTintColor;
}

- (UIColor *)borderTintColor {
    if (_borderTintColor == nil) {
        _borderTintColor = [UIColor colorWithWhite:0.8 alpha:0.8];
    }
    return _borderTintColor;
}

#pragma mark - 绘图
- (void)drawRect:(CGRect)rect {
    
    // 1. 基本数据准备
    if (rect.size.width == 0 || rect.size.height == 0) {
        return;
    }
    
    // 2. 如果已经完成，隐藏
    if (_progress >= 1.0) {
        return;
    }
    
    CGFloat radius = MIN(rect.size.width, rect.size.height) * 0.5;
    CGPoint center = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    
    // 3. 绘制外圈
    [self.borderTintColor setStroke];
    
    CGFloat lineWidth = 2.0;
    UIBezierPath *borderPath = [UIBezierPath bezierPathWithArcCenter:center
                                                              radius:radius - lineWidth * 0.5
                                                          startAngle:0
                                                            endAngle:2 * M_PI
                                                           clockwise:YES];
    borderPath.lineWidth = lineWidth;
    
    [borderPath stroke];
    
    // 4. 绘制内圆
    [self.trackTintColor setFill];
    radius -= lineWidth * 2;
    UIBezierPath *trackPath = [UIBezierPath bezierPathWithArcCenter:center
                                                             radius:radius
                                                         startAngle:0
                                                           endAngle:2 * M_PI
                                                          clockwise:YES];
    [trackPath fill];
    
    // 5. 绘制进度
    [self.progressTintColor set];
    
    CGFloat start = -M_PI_2;
    CGFloat end = start + self.progress * M_PI * 2;
    UIBezierPath *progressPath = [UIBezierPath bezierPathWithArcCenter:center
                                                                radius:radius
                                                            startAngle:start
                                                              endAngle:end
                                                             clockwise:YES];
    [progressPath addLineToPoint:center];
    [progressPath closePath];
    
    [progressPath fill];
}

@end
