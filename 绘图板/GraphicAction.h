//
//  GraphicAction.h
//  绘图板
//
//  Created by 梁尚嘉 on 16/4/27.
//  Copyright © 2016年 ST. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface GraphicAction : NSObject

@property (nonatomic, assign) CGFloat       lineWidth; //线条的组细
@property (nonatomic, strong) NSString      *lineColorHexStr;//线条的颜色16进制字符串
@property (nonatomic, strong) UIBezierPath  *path;//线条的路径

@property (nonatomic, strong) NSMutableArray <NSString *> *pointValues;

@end
