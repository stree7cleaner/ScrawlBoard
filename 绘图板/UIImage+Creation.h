//
//  UIImage+Creation.h
//  绘图板
//
//  Created by liangshangjia on 16/4/28.
//  Copyright © 2016年 ST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Creation)
/**
 *  截取某view的视图
 *  @param view 某个视图
 *  @return image
 */
+ (UIImage *) captureInView:(UIView *)view;

@end
