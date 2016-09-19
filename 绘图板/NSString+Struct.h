//
//  NSString+CGPoint.h
//  绘图板
//
//  Created by 梁尚嘉 on 16/4/28.
//  Copyright © 2016年 ST. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Struct)

/**
 *  CGPoint获取字符串@"x,y";
 */
+ (NSString *)stringWithCGPoint:(CGPoint)point;


/**
 *  字符串获取CGPoint
 */
- (CGPoint)CGPointValue;


@end
