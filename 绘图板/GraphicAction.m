//
//  GraphicAction.m
//  绘图板
//
//  Created by 梁尚嘉 on 16/4/27.
//  Copyright © 2016年 ST. All rights reserved.
//

#import "GraphicAction.h"
#import "GraphicMacro.h"

#import <MJExtension.h>

#import "UIBezierPath+Parser.h"

@implementation GraphicAction
- (instancetype)init
{
    if (self = [super init]) {
        self.lineWidth  = 1.f;
        self.lineColorHexStr  = kGraphicDefaultColorHexStr;
    }
    return self;
}

- (NSMutableArray<NSString *> *)pointValues
{
    if (!_pointValues && _path) {
        _pointValues = [UIBezierPath pointValuesWithBezierPath:self.path];
    }
    return _pointValues;
}


- (UIBezierPath *)path
{
    if (!_path && _pointValues) {
        _path = [UIBezierPath bezierPathWithPoints:self.pointValues];
    }
    return _path;
}


//MJ模型JSON转换中数组类型的指定
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"pointValues" : @"NSString"
             };
}

//MJ模型JSON转换中忽略的字段
+ (NSArray *)mj_ignoredPropertyNames
{
    return @[@"path"];
}
@end
