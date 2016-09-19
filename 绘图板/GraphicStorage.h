//
//  GraphicStorage.h
//  绘图板
//
//  Created by liangshangjia on 16/4/28.
//  Copyright © 2016年 ST. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  画图数据模型
 */
#import "GraphicAction.h"

@interface GraphicStorage : NSObject
//已选择的颜色
@property (nonatomic, strong) NSString *currentColorHexStr;//颜色16进制字符串

//所有操作
@property (nonatomic, strong) NSMutableArray<GraphicAction *> *actions;

//垃圾箱
@property (nonatomic, strong) NSMutableArray<GraphicAction *> *trashBox;

//截图路径
@property (nonatomic, strong) NSString *screenshotPath;//using [UIImage imageWithContentOfFile:screenshotPath];

//唯一识别码
@property (nonatomic, strong) NSString *uuid;

//涂鸦名称
@property (nonatomic, strong) NSString *name;

//更新时间
@property (nonatomic, assign) NSTimeInterval timestamp;

//不存入数据库
@property (nonatomic, strong) UIImage *image;

@end
