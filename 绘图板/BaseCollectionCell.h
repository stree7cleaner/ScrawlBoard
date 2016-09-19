//
//  BaseCollectionCell.h
//  绘图板
//
//  Created by liangshangjia on 16/4/29.
//  Copyright © 2016年 ST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCollectionCell : UICollectionViewCell

- (void)configure NS_REQUIRES_SUPER;

- (void)configureCellWithObject:(id)anObj;


/**
 *  重用识别码
 *  @return 识别码
 */
+ (NSString *)cellIdentifier;

@end
