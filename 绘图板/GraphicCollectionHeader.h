//
//  GraphicCollectionHeader.h
//  绘图板
//
//  Created by liangshangjia on 16/4/29.
//  Copyright © 2016年 ST. All rights reserved.
//

#ifndef GraphicCollectionHeader_h
#define GraphicCollectionHeader_h

#define GCollectionViewCellWidth ((SCREEN_SIZE.width - 3 *GCollectionViewLeftRightMargin)/2.f)

#define GCollectionViewCellHeight (GCollectionViewCellWidth*1.4)

#define GCollectionViewCellMargin 10.f

#define GImageViewWidth (GCollectionViewCellWidth - 2*GCollectionViewCellMargin)

#define GImageViewHeight (GImageViewWidth * (GCollectionViewCellHeight / GCollectionViewCellWidth))



#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
#define GCollectionViewLeftRightMargin 15.f

#endif /* GraphicCollectionHeader_h */
