//
//  NSString+CZBase64.m
//
//  Created by 刘凡 on 16/6/7.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "NSString+CZBase64.h"

@implementation NSString (CZBase64)

- (NSString *)cz_base64Encode {
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    return [data base64EncodedStringWithOptions:0];
}

- (NSString *)cz_base64Decode {
    
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end
