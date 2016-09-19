//
//  GraphicStorage.m
//  绘图板
//
//  Created by liangshangjia on 16/4/28.
//  Copyright © 2016年 ST. All rights reserved.
//

#import "GraphicStorage.h"
#import <MJExtension.h>
#import <UIKit/UIKit.h>

#import "GraphicMacro.h"
@implementation GraphicStorage

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"actions"     : @"GraphicAction",
             @"trashBox"    : @"GraphicAction"
             };
}

- (NSMutableArray<GraphicAction *> *)trashBox
{
    if (!_trashBox) {
        _trashBox = [NSMutableArray array];
    }
    return _trashBox;
}


- (NSMutableArray<GraphicAction *> *)actions
{
    if (!_actions) {
        _actions = [NSMutableArray arrayWithCapacity:0];
    }
    return _actions;
}


- (NSString *)currentColorHexStr
{
    if (!_currentColorHexStr) {
        _currentColorHexStr = kGraphicDefaultColorHexStr;
    }
    return _currentColorHexStr;
}


- (NSString *)uuid
{
    if (!_uuid) {
        _uuid = [[NSUUID UUID] UUIDString];
    }
    return _uuid;
}


//MJ模型JSON转换中忽略的字段
+ (NSArray *)mj_ignoredPropertyNames
{
    return @[@"image"];
}

@end
