//
//  GraphicCollectionView.m
//  绘图板
//
//  Created by liangshangjia on 16/4/29.
//  Copyright © 2016年 ST. All rights reserved.
//

#import "GraphicCollectionView.h"

#import "GraphicCollectionHeader.h"

@implementation GraphicCollectionView

+ (instancetype)collecitonView
{
    GraphicCollectionView *collectionView = [[self alloc]initWithFrame:CGRectZero collectionViewLayout:[self collectionViewLayout]];
    [collectionView configure];
    return collectionView;
}

- (void)configure
{
    self.alwaysBounceVertical   = YES;
    self.backgroundColor        = [UIColor groupTableViewBackgroundColor];
}

+ (UICollectionViewFlowLayout *)collectionViewLayout
{
    UICollectionViewFlowLayout *layout  = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize                     = CGSizeMake(GCollectionViewCellWidth, GCollectionViewCellHeight);
    layout.minimumInteritemSpacing      = GCollectionViewLeftRightMargin/2;
    layout.minimumLineSpacing           = GCollectionViewLeftRightMargin*2;
    layout.sectionInset                 = UIEdgeInsetsMake(
                                                           GCollectionViewLeftRightMargin*3,
                                                           GCollectionViewLeftRightMargin,
                                                           GCollectionViewLeftRightMargin*3,
                                                           GCollectionViewLeftRightMargin
                                                           );
    return layout;
}
@end
