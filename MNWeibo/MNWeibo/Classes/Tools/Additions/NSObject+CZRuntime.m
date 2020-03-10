//
//  NSObject+CZRuntime.m
//  004-AFN封装
//
//  Created by 刘凡 on 16/6/11.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "NSObject+CZRuntime.h"
#import <objc/runtime.h>

@implementation NSObject (CZRuntime)

+ (NSArray *)cz_objectsWithArray:(NSArray *)array {
    
    if (array.count == 0) {
        return nil;
    }
    
    // 断言是字典数组
    NSAssert([array[0] isKindOfClass:[NSDictionary class]], @"必须传入字典数组");

    // 0. 获得属性数组
    NSArray *list = [self cz_propertiesList];
    
    // 1. 遍历数组
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        
        // 2. 创建对象
        id obj = [self new];
        
        // 3. 遍历字典
        for (NSString *key in dict) {
            // 判断字典中的 key 是否在成员变量中存在
            if (![list containsObject:key]) {
                continue;
            }
            
            [obj setValue:dict[key] forKey:key];
        }
        
        // 4. 将对象添加到数组
        [arrayM addObject:obj];
    }
    
    return arrayM.copy;
}

void *propertiesKey = "cn.itcast.propertiesList";

+ (NSArray *)cz_propertiesList {
    
    // 获取关联对象
    NSArray *result = objc_getAssociatedObject(self, propertiesKey);
    
    if (result != nil) {
        return result;
    }
    
    unsigned int count = 0;
    objc_property_t *list = class_copyPropertyList([self class], &count);
    
    // 遍历所有的属性
    NSMutableArray *arrayM = [NSMutableArray array];
    
    for (unsigned int i = 0; i < count; i++) {
    
        objc_property_t pty = list[i];
        
        // 获取 ivar 名称
        const char *cName = property_getName(pty);
        NSString *name = [NSString stringWithUTF8String:cName];
        
        [arrayM addObject:name];
    }
    
    free(list);
    
    // 设置关联对象
    objc_setAssociatedObject(self, propertiesKey, arrayM, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return objc_getAssociatedObject(self, propertiesKey);
}

void *ivarsKey = "cn.itcast.ivarsList";

+ (NSArray *)cz_ivarsList {
    
    // 获取关联对象
    NSArray *result = objc_getAssociatedObject(self, ivarsKey);
    
    if (result != nil) {
        return result;
    }
    
    unsigned int count = 0;
    Ivar *list = class_copyIvarList([self class], &count);
    
    // 遍历所有的属性
    NSMutableArray *arrayM = [NSMutableArray array];
    
    for (unsigned int i = 0; i < count; i++) {
        
        Ivar ivar = list[i];
        
        // 获取 ivar 名称
        const char *cName = ivar_getName(ivar);
        NSString *name = [NSString stringWithUTF8String:cName];
        
        [arrayM addObject:name];
    }
    
    free(list);
    
    // 设置关联对象
    objc_setAssociatedObject(self, ivarsKey, arrayM, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return objc_getAssociatedObject(self, ivarsKey);
}


@end
