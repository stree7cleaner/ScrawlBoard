//
//  GraphicBoard.h
//  绘图板
//
//  Created by 梁尚嘉 on 16/4/27.
//  Copyright © 2016年 ST. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GraphicStorage.h"
@interface GraphicBoard : UIView

@property (nonatomic, strong) void (^callback)(UIBezierPath *path);

@property (nonatomic, strong) GraphicStorage *currentGraphic;
@property (nonatomic, strong) UIColor *currentColor;



- (void)setGraphic:(GraphicStorage *)graphic;


/**
 *  前进一步
 */
- (void)forwards;

/**
 *  退后一步
 */
- (void)backwards;

/**
 *  保存到数据库
 */
- (void)save;

/**
 *  清空
 */
- (void)clear;


@end
