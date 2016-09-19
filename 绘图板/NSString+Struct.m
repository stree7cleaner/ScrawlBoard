//
//  NSString+CGPoint.m
//  绘图板
//
//  Created by 梁尚嘉 on 16/4/28.
//  Copyright © 2016年 ST. All rights reserved.
//

#import "NSString+Struct.h"

@implementation NSString (Struct)
+ (NSString *)stringWithCGPoint:(CGPoint)point
{
    return [NSString stringWithFormat:@"%f,%f",point.x,point.y];
}


- (CGPoint)CGPointValue
{
    CGPoint point = CGPointZero;
    NSArray *array = [self componentsSeparatedByString:@","];
    if (array.count == 2) {
        point.x = [array[0] floatValue];
        point.y = [array[1] floatValue];
    }
    return point;
}

@end
