//
//  STProgressView.m
//  绘图板
//
//  Created by liangshangjia on 16/4/29.
//  Copyright © 2016年 ST. All rights reserved.
//

#import "STProgressView.h"

#import <SVProgressHUD.h>

@implementation STProgressView

+ (void)showStatus:(NSString *)status andEnableUserInteraction:(BOOL)enable
{
    [SVProgressHUD showWithStatus:status maskType:enable ? SVProgressHUDMaskTypeNone : SVProgressHUDMaskTypeGradient];
}


+ (void)showBlockedStatus:(NSString *)status
{
    [self showStatus:status andEnableUserInteraction:NO];
}

+ (void)showStatus:(NSString *)status
{
    [self showStatus:status andEnableUserInteraction:YES];
}


+ (void)dismiss
{
    [SVProgressHUD dismiss];
}


+ (void)showSuccessInfo:(NSString *)info
{
    [SVProgressHUD showSuccessWithStatus:info maskType:SVProgressHUDMaskTypeGradient];
}



+ (void)showErrorInfo:(NSString *)info
{
    [SVProgressHUD showErrorWithStatus:info maskType:SVProgressHUDMaskTypeGradient];
}



+ (void)showInfo:(NSString *)info
{
    [SVProgressHUD showInfoWithStatus:info maskType:SVProgressHUDMaskTypeGradient];
}


@end
