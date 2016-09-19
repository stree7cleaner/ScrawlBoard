//
//  UIBezierPath+Parser.m
//  绘图板
//
//  Created by liangshangjia on 16/4/28.
//  Copyright © 2016年 ST. All rights reserved.
//

#import "UIBezierPath+Parser.h"
#import "NSString+Struct.h"

@implementation UIBezierPath (Parser)


+ (NSMutableArray<NSString *> *)pointValuesWithBezierPath:(UIBezierPath *)path
{
    CGPathRef cgPath = path.CGPath;
    NSMutableArray *bezierPathPoints = [NSMutableArray array];
    CGPathApply(cgPath, (__bridge void * _Nullable)(bezierPathPoints), CGPathApplierFunc);
    return bezierPathPoints;
}



+ (instancetype)bezierPathWithPoints:(NSMutableArray<NSString *> *)points
{
    return ({
        UIBezierPath *path = [UIBezierPath bezierPath];
        NSInteger i = 0;
        for (NSString *pointStr in points) {
            CGPoint point = [pointStr CGPointValue];
            if (i == 0) {
                [path moveToPoint:point];
            }else {
                [path addLineToPoint:point];
            }
            i ++;
        }
        path;
    });
}




void CGPathApplierFunc (void *info, const CGPathElement *element)
{
    
    NSMutableArray *bezierPoints = (__bridge NSMutableArray *)info;
    CGPoint *points = element->points;
    CGPathElementType type = element->type;
    
    switch(type) {
        case kCGPathElementMoveToPoint: // contains 1 point
            [bezierPoints addObject:[NSString stringWithCGPoint:points[0]]];
            break;
            
        case kCGPathElementAddLineToPoint: // contains 1 point
            [bezierPoints addObject:[NSString stringWithCGPoint:points[0]]];
            break;
            
        case kCGPathElementAddQuadCurveToPoint: // contains 2 points
            [bezierPoints addObject:[NSString stringWithCGPoint:points[0]]];
            [bezierPoints addObject:[NSString stringWithCGPoint:points[1]]];
            break;
            
        case kCGPathElementAddCurveToPoint: // contains 3 points
            [bezierPoints addObject:[NSString stringWithCGPoint:points[0]]];
            [bezierPoints addObject:[NSString stringWithCGPoint:points[1]]];
            [bezierPoints addObject:[NSString stringWithCGPoint:points[2]]];
            break;
            
        case kCGPathElementCloseSubpath: // contains no point
            break;
    }
}



@end
