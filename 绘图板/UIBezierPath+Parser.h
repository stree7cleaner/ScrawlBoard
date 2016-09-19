//
//  UIBezierPath+Parser.h
//  绘图板
//
//  Created by liangshangjia on 16/4/28.
//  Copyright © 2016年 ST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBezierPath (Parser)

/**
 *  计算bezierPath所含的点数
 *  @param path UIBezierPath
 *  @return NSMutableArray
 */
+ (NSMutableArray <NSString *> *)pointValuesWithBezierPath:(UIBezierPath *)path;


/**
 *  根据点集合构造BezierPath
 *  @param points
 *  @return UIBezierPath
 */
+ (instancetype)bezierPathWithPoints:(NSMutableArray <NSString *> *)points;


@end
