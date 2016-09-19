//
//  UIImage+Creation.m
//  绘图板
//
//  Created by liangshangjia on 16/4/28.
//  Copyright © 2016年 ST. All rights reserved.
//

#import "UIImage+Creation.h"

@implementation UIImage (Creation)


+ (UIImage *) captureInView:(UIView *)view
{
    CGRect rect = view.bounds;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}






@end
