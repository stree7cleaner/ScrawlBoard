//
//  StorageTool.m
//  绘图板
//
//  Created by liangshangjia on 16/4/28.
//  Copyright © 2016年 ST. All rights reserved.
//

#import "StorageTool.h"

#define kFileManager [NSFileManager defaultManager]

#import "GraphicStorage.h"

#import <MJExtension.h>

#import <FMDB.h>

@implementation StorageTool

+ (void)storageFile:(NSData *)data withPath:(NSString *)path
{
    
    NSString *fileDirectory = [path stringByDeletingLastPathComponent];
    
    BOOL isDirecotry;
    BOOL isExists = [kFileManager fileExistsAtPath:fileDirectory
                                       isDirectory:&isDirecotry];
    if (!isExists) {
        
        NSError *error;
        BOOL success =[kFileManager createDirectoryAtPath:fileDirectory
                              withIntermediateDirectories:nil
                                               attributes:nil
                                                    error:&error];
        if (error || !success) {
            NSLog(@"保存数据到%@失败",path);
            return;
        }
    }
    
    if (![kFileManager createFileAtPath:path
                               contents:data
                             attributes:nil]) {
        NSLog(@"保存数据到%@失败",path);
    }
    
}


+ (NSData *)fileDataWithPath:(NSString *)path
{
    NSData *data = [NSData dataWithContentsOfFile:path];
    if (!data) {
        NSLog(@"文件不存在");
    }
    return data;
}

+ (void)saveGraphic:(GraphicStorage *)storage onComplection:(GraphicSaveBlock)complection
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        NSDictionary *dic               = [storage mj_JSONObject] ;
        NSArray *actions                = dic[@"actions"];
        NSString *actionsJsonStr        = [actions mj_JSONString]; //数组转字符串
        NSArray *trashBox               = dic[@"trashBox"];
        NSString *trashBoxJsonStr       = [trashBox mj_JSONString];//数组转字符串
        NSString *currentColorHexStr    = dic[@"currentColorHexStr"];
        NSString *screenshotPath        = dic[@"screenshotPath"];
        NSString *uuid                  = dic[@"uuid"];
        NSTimeInterval timestamp        = [[NSDate date] timeIntervalSince1970];
        NSString *name                  = dic[@"name"];
        
        [[FMDatabaseQueue databaseQueueWithPath:graphicDBPath] inDatabase:^(FMDatabase *db) {
            //若表Graphics不存在则创建表
            BOOL success = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS Graphics(uuid varchar(255),actions LONGTEXT,trashBox LONGTEXT,currentColorHexStr varchar(100),screenshotPath LONGTEXT,timestamp double(11,2));"];
            
            //若表Graphics的字段name不存在则添加到表中
            BOOL isExist = [db executeUpdate:@"SELECT * from Graphics WHERE name='name';"];
            if (!isExist) {
                //添加name 字段到表
                [db executeUpdate:@"ALTER TABLE Graphics ADD name varchar(255);"];
            }
            
            if (success) {
                //查询数据是否存在
                NSString *searchSQL = [NSString stringWithFormat:@"SELECT * FROM Graphics WHERE uuid='%@'",uuid];
                FMResultSet *result = [db executeQuery:searchSQL];
                BOOL isDataExist = NO;
                while ([result next]) {
                    isDataExist = YES;break;
                }
                [result close];
                
                if (!isDataExist) { //创建记录
                    success = [db executeUpdate:@"INSERT INTO Graphics (uuid ,actions ,trashBox ,currentColorHexStr ,screenshotPath ,timestamp ,name) VALUES(?,?,?,?,?,?,?);",uuid,actionsJsonStr,trashBoxJsonStr,currentColorHexStr,screenshotPath,@(timestamp),name];
                    
                }else {//更新记录
                    
                    success =[db executeUpdate:[NSString stringWithFormat:@"UPDATE  Graphics SET actions='%@',trashBox='%@',currentColorHexStr='%@',screenshotPath='%@',timestamp='%@',name='%@' WHERE uuid='%@';",actionsJsonStr,trashBoxJsonStr,currentColorHexStr,screenshotPath,@(timestamp),name,uuid]];
                    
                }
                !complection ?: complection(success);
            }else {
                !complection ?: complection(NO);
            }
            
        }];
    });
    
}


+ (void)fetchAllGraphicsWithResult:(GraphicSearchResultBlock)resultBlock
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        [[FMDatabaseQueue databaseQueueWithPath:graphicDBPath] inDatabase:^(FMDatabase *db) {
            
            //获取表Graphics所有数据
            FMResultSet *result                         = [db executeQuery:@"select * from Graphics"];
            NSMutableArray<GraphicStorage *> *objects   = [NSMutableArray array];
            
            //遍历
            while ([result next]) {
                
                int count = [result columnCount];
                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:count];
                
                for (int i = 0; i < count; i ++) {
                    
                    NSString *key   = [result columnNameForIndex:i];
                    id value        = [result stringForColumnIndex:i];
                    
                    if ([key isEqualToString:@"actions"]||[key isEqualToString:@"trashBox"]) {
                        
                        value = [value mj_JSONObject];
                    }else if([key isEqualToString:@"name"] && !value){
                        
                        value = @"未命名";
                    }
                    
                    [dic setObject:value?value:@"空" forKey:key];
                }
                
                [objects addObject:[GraphicStorage mj_objectWithKeyValues:dic]];
            }
            [result close];
            
            //加载图片
            for (GraphicStorage *storage in objects) {
                UIImage *image = [UIImage imageWithData:[StorageTool fileDataWithPath:screenshotPath(storage.uuid)]];
                storage.image  = image;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                !resultBlock ?:resultBlock(objects);
            });
        }];
    });
    
}


@end
