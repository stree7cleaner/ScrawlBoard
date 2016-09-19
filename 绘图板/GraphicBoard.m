//
//  GraphicBoard.m
//  绘图板
//
//  Created by 梁尚嘉 on 16/4/27.
//  Copyright © 2016年 ST. All rights reserved.
//

#import "GraphicBoard.h"

#import "GraphicAction.h"

#import "UIImage+Creation.h"

#import "StorageTool.h"

#import <MJExtension.h>

#import <HexColors.h>

#import "UIColor+Parser.h"

#import "UIBezierPath+Parser.h"

#import "NSString+Struct.h"
#import "NotificationMacro.h"

#import "STProgressView.h"



@implementation GraphicBoard
{
    NSMutableArray    *_points;         //当前的一次触摸的所有点
    GraphicAction     *_currentAction;  //当前的一次触摸的自定义模型(保存轨迹、线条的粗细、颜色)
}


#pragma mark - Lifeloop
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self configure];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self configure];
    }
    return self;
}

- (void)configure
{
    self.backgroundColor = [UIColor clearColor];
}

#pragma mark - Touch
//保存点（CGPoint->NSString)
- (void)addPoint:(CGPoint)point
{
    [_points addObject:[NSString stringWithCGPoint:point]];
}

//获取点
- (CGPoint)pointWithTouches:(NSSet<UITouch *> *)touches
{
    UITouch *touch  = [touches anyObject];
    return [touch locationInView:self];
}

//触摸开始事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _points         = [NSMutableArray array];
    _currentAction  = [[GraphicAction alloc]init];
    _currentAction.lineColorHexStr = self.currentGraphic.currentColorHexStr ? self.currentGraphic.currentColorHexStr :_currentAction.lineColorHexStr;
    [self.currentGraphic.trashBox removeAllObjects];
    [self.currentGraphic.actions addObject:_currentAction];

    //保存点
    [self addPoint:[self pointWithTouches:touches]];
}

//触摸移动事件
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self addPoint:[self pointWithTouches:touches]];
    _currentAction.path = [UIBezierPath bezierPathWithPoints:_points];
    [self setNeedsDisplay];
}

//触摸结束事件
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self addPoint:[self pointWithTouches:touches]];
    _currentAction.path = [UIBezierPath bezierPathWithPoints:_points];
    [self setNeedsDisplay];
}




#pragma mark - Draw

//画线(组细,上色)
- (void)drawRect:(CGRect)rect
{

    for (GraphicAction *action in self.currentGraphic.actions) {
        [[UIColor hx_colorWithHexRGBAString:action.lineColorHexStr] setStroke];
        [action.path setLineWidth:action.lineWidth];
        [action.path stroke];
    }

}

#pragma mark - Setters
- (void)setCurrentColor:(UIColor *)currentColor
{
    _currentColor = currentColor;
    self.currentGraphic.currentColorHexStr = [currentColor getHexString];
}

- (void)setGraphic:(GraphicStorage *)graphic
{
    _currentGraphic = graphic;
    [self setNeedsDisplay];
}

#pragma mark - Getters
- (GraphicStorage *)currentGraphic
{
    if (!_currentGraphic) {
        _currentGraphic = [[GraphicStorage alloc]init];
    }
    return _currentGraphic;
}


#pragma mark - Actions

- (void)forwards
{
    GraphicAction *action = [self.currentGraphic.trashBox lastObject];
    if (!action) {
        return;
    }
    [self.currentGraphic.trashBox removeLastObject];
    [self.currentGraphic.actions addObject:action];
    [self setNeedsDisplay];
}

- (void)backwards
{
    GraphicAction *action = [self.currentGraphic.actions lastObject];
    if (!action) {
        return;
    }
    [self.currentGraphic.actions removeLastObject];
    [self.currentGraphic.trashBox addObject:action];
    [self setNeedsDisplay];
}

- (void)clear
{
    [self.currentGraphic.trashBox removeAllObjects];
    [self.currentGraphic.actions removeAllObjects];
    [self setNeedsDisplay];
}

- (void)save
{

    UIImage *screenshot = [UIImage captureInView:self];
    NSString *pathOfScreenshot = screenshotPath(self.currentGraphic.uuid);
    [StorageTool storageFile:UIImageJPEGRepresentation(screenshot, .1) withPath:pathOfScreenshot];
    self.currentGraphic.screenshotPath = pathOfScreenshot;

    [STProgressView showBlockedStatus:nil];
    [StorageTool saveGraphic:self.currentGraphic onComplection:^(BOOL success) {
        
        //延时显示
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            success ? [STProgressView showSuccessInfo:@"保存成功"] : [STProgressView showErrorInfo:@"保存失败"];
        });
        
        //发送通知数据库已更新
        [[NSNotificationCenter defaultCenter] postNotificationName:GSGraphicUpdateInDataBaseNotificationKey object:nil];
    }];

}




@end
