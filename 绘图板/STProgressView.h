//
//  STProgressView.h
//  绘图板
//
//  Created by liangshangjia on 16/4/29.
//  Copyright © 2016年 ST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STProgressView : UIView


/**
 *  HUD显示
 *  @param status 提示信息
 *  @param enable 是否允许用户交互
 */
+ (void)showStatus:(NSString *)status andEnableUserInteraction:(BOOL)enable;

/**
 *  HUD显示(不允许用户交互)
 *  @param status 提示信息
 */
+ (void)showBlockedStatus:(NSString *)status;

/**
 *  HUD显示(允许用户交互)
 *  @param status 提示信息
 */
+ (void)showStatus:(NSString *)status;


/**
 *  隐藏HUD
 */
+ (void)dismiss;



/**
 *  显示成功信息
 *  @param info 信息
 */
+ (void)showSuccessInfo:(NSString *)info;


/**
 *  显示成功信息
 *  @param info 信息
 */
+ (void)showErrorInfo:(NSString *)info;


/**
 *  显示信息(中性)
 *  @param info 信息
 */
+ (void)showInfo:(NSString *)info;




- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
@end
