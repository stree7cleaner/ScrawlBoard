//
//  BaseCollectionCell.m
//  绘图板
//
//  Created by liangshangjia on 16/4/29.
//  Copyright © 2016年 ST. All rights reserved.
//

#import "BaseCollectionCell.h"

@implementation BaseCollectionCell


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self configure];
    }
    return self;
}

- (void)configure
{
    //空实现
}


- (void)configureCellWithObject:(id)anObj
{
    //空实现
}



+ (NSString *)cellIdentifier
{
    return NSStringFromClass([super class]);
}

@end
