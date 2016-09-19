//
//  StorageTool.h
//  绘图板
//
//  Created by liangshangjia on 16/4/28.
//  Copyright © 2016年 ST. All rights reserved.
//

#import <Foundation/Foundation.h>

#define screenshotPath(name) [NSString stringWithFormat:@"%@/graphicScreenshot/%@",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0],name]

#define graphicDBPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"graphics.db"]

@class GraphicStorage;

typedef void (^GraphicSaveBlock)(BOOL success);
typedef void (^GraphicSearchResultBlock)(NSArray <GraphicStorage *>*graphics);

@interface StorageTool : NSObject
/**
 *  保存数据到本地
 *  @param data OC数据流
 *  @param path 保存路径
 */
+ (void)storageFile:(NSData *)data withPath:(NSString *)path;


/**
 *  读取本地数据
 *  @param path 数据文件路径
 *  @return data OC数据流
 */
+ (NSData *)fileDataWithPath:(NSString *)path;


/**
 *  保存画图数据(sql)
 */
+ (void)saveGraphic:(GraphicStorage *)storage onComplection:(GraphicSaveBlock)complection;



/**
 *  搜索所有画图数据
 */
+ (void)fetchAllGraphicsWithResult:(GraphicSearchResultBlock)result;

@end
