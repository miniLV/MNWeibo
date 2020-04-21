//
//  HMPhotoBrowserPhotos.m
//  HMPhotoBrowser
//
//  Created by 刘凡 on 16/3/13.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HMPhotoBrowserPhotos.h"

@implementation HMPhotoBrowserPhotos

- (NSString *)description {
    NSArray *keys = @[@"selectedIndex", @"urls", @"parentImageViews"];
    
    return [self dictionaryWithValuesForKeys:keys].description;
}

@end
