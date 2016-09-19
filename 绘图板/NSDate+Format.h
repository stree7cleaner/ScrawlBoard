//
//  NSDate+Format.h
//  XZLife
//
//  Created by 梁尚嘉 on 15/8/31.
//  Copyright (c) 2015年 Sami-industry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Format)

+ (NSString *)dateStringWithFormat:(NSString *)format withDate:(NSDate *)date;

+ (NSDate *)dateWithFormat:(NSString *)format withDateString:(NSString *)dateStr;

@end
