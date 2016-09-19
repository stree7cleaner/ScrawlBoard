//
//  GraphicListCollectionCell.m
//  绘图板
//
//  Created by liangshangjia on 16/4/29.
//  Copyright © 2016年 ST. All rights reserved.
//

#import "GraphicListCollectionCell.h"

#import <Masonry.h>

#import "GraphicStorage.h"

#import "NSString+TimeStamp.h"

#import "GraphicCollectionHeader.h"

#import <HexColors.h>
@interface GraphicListCollectionCell ()
@property (nonatomic, strong) UIImageView       *imageView;
@property (nonatomic, strong) UILabel           *elementLabel;
@end

@implementation GraphicListCollectionCell
/**
 *  初化调置
 */
- (void)configure
{
    [super configure];
    _imageView = [[UIImageView alloc]init];
    _imageView.clipsToBounds = YES;
    [self.contentView addSubview:self.imageView];
    
    _elementLabel           = [[UILabel alloc]init];
    _elementLabel.font      = [UIFont systemFontOfSize:13];
    _elementLabel.textColor = [UIColor hx_colorWithHexRGBAString:@"#377783"];
    [self.contentView addSubview:self.elementLabel];
    

    [self setupConstraints];
}

/**
 *  设置约束
 */
- (void)setupConstraints
{
    
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.width.equalTo(@(GImageViewWidth));
        make.height.equalTo(@(GImageViewHeight));
        make.centerX.equalTo(self.contentView.mas_centerX);
    }];
    
    [self.elementLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(GCollectionViewCellMargin);
        make.centerX.equalTo(self.imageView.mas_centerX);
    }];
    
}


- (void)configureCellWithObject:(GraphicStorage *)anObj
{
    //CALAYER显式动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"contents"];
    animation.fromValue         = (__bridge id _Nullable)_imageView.image.CGImage;
    animation.toValue           = (__bridge id _Nullable)anObj.image.CGImage;
    animation.duration          = 1.f;
    [_imageView.layer addAnimation:animation forKey:nil];
    
    
    _imageView.image = anObj.image;
    _elementLabel.text = anObj.name;//[NSString getTimeRemindWithTimeIntervalSince1970:anObj.timestamp];
}
@end
