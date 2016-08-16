//
//  CartoonRadioDB.m
//  CartoonOnlie
//
//  Created by zhiling on 16/8/10.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "CartoonRadioDB.h"
#import "RadioModel.h"
#import "FMDB.h"

@interface CartoonRadioDB ()

@property (nonatomic, strong) FMDatabase *db;

@property (nonatomic, strong) NSString *tableName;

@end

@implementation CartoonRadioDB



- (NSString *)dataBasePath {
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSLog(@"%@", path);
    
    NSString *createPath = [NSString stringWithFormat:@"%@/sqlFile", path];
    //    NSString *createDir = [NSString stringWithFormat:@""]
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    // 判断文件夹是否存在，如果不存在，则创建
    if (![[NSFileManager defaultManager] fileExistsAtPath:createPath]) {
        [fileManager createDirectoryAtPath:createPath withIntermediateDirectories:YES attributes:nil error:nil];

    } else {
        NSLog(@"FileDir is exists.");
    }
    
//    path = [createPath stringByAppendingPathComponent:@"Terrofying.sqlite"];
    NSString *tableName = [NSString stringWithFormat:@"%@.sqlite", self.tableName];
    path = [createPath stringByAppendingPathComponent:tableName];
    return path;
    
}

- (void)createTableWithName:(NSString *)name {
    self.tableName = name;
    
    self.db = [FMDatabase databaseWithPath:[self dataBasePath]];
 
    if ([self.db open]) {
        
        //hot_radios  musics wiki_id
        if ([name isEqualToString:@"hot_musics"]) {
            
            NSString *sqlStr = [NSString stringWithFormat:@"create table if not exists %@(n_id integer primary key, n_title text, n_picUrl text,n_lagerUrl text, n_ids text);", name];
            
            NSLog(@"%@", sqlStr);
            [self.db executeUpdate:sqlStr];

            
        }else if ([name isEqualToString:@"hot_radios"]) {
            
            
            NSString *sqlStr = [NSString stringWithFormat:@"create table if not exists %@(n_id integer primary key, n_title text, n_picUrl text, n_lagerUrl text, n_ids text);", name];
            
            NSLog(@"%@", sqlStr);
            [self.db executeUpdate:sqlStr];

            
        }else if ([name isEqualToString:@"musics"]) {
            
            
            NSString *sqlStr = [NSString stringWithFormat:@"create table if not exists %@(n_id integer primary key, n_title text, n_picUrl text,n_lagerUrl text, n_ids text);", name];
            
            NSLog(@"%@", sqlStr);
            [self.db executeUpdate:sqlStr];

            
        }else if ( [name isEqualToString:@"new_musics"]) {
            
            
            NSString *sqlStr = [NSString stringWithFormat:@"create table if not exists %@(n_id integer primary key, n_title text, n_picUrl text,n_lagerUrl text, n_ids text);", name];
            
            NSLog(@"%@", sqlStr);
            [self.db executeUpdate:sqlStr];
            
        }
     
        }
    
    [self.db close];
 
    
}


+ (CartoonRadioDB *)shareDataHandler{
    
    static CartoonRadioDB *dataHandler = nil;
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        dataHandler = [[CartoonRadioDB alloc] init];
      
    });
    
    return dataHandler;
}


- (void)RadioModelModelWithTableName:(NSString *)tableName model:(RadioModel *)model {
    
    if ([self.db open]) {
        NSLog(@"打开数据库开始存储数据");
//        NSString *sqlStr1 = [NSString stringWithFormat:@"insert into %@", self.tableName];
//        model.wiki_cover[@"small"];
        NSString *sqlStr = [NSString stringWithFormat:@"insert into %@(n_title, n_picUrl, n_lagerUrl , n_ids) values (?, ?, ?, ?);", tableName];

        [self.db executeUpdate:sqlStr, model.wiki_title, model.wiki_cover[@"small"],model.wiki_cover[@"large"], model.wiki_id];
        
        [self.db close];
        
    }
    [self.db close];
    
}

- (NSArray *)allModelWithTableName:(NSString *)tableName {
    
    if ([self.db open]) {
        
        NSMutableArray *mArray = [[NSMutableArray alloc] init];
        
        NSString *sqlStr = [NSString stringWithFormat:@"select * from %@",tableName];
        
        
        
        FMResultSet *resultSet = [self.db executeQuery:sqlStr];
        
        while ([resultSet next]) {
            
            RadioModel *model = [[RadioModel alloc] init];
            model.wiki_title = [resultSet stringForColumn:@"n_title"];
            
            NSString *pic = [resultSet stringForColumn:@"n_picUrl"];
            
            NSString *lagerPic = [resultSet stringForColumn:@"n_lagerUrl"];
            
            model.wiki_id = [resultSet stringForColumn:@"n_ids"];
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            
            [dict setObject:pic forKey:@"small"];
            [dict setObject:lagerPic forKey:@"large"];
            model.wiki_cover = dict;
            [mArray addObject:model];
        
        }
        [self.db close];
        return [mArray copy];
    }
    return nil;
}


- (BOOL)deleteModelWithTableName:(NSString *)tableName {
    
    
    if ([self.db open]) {
         NSString *sqlStr = [NSString stringWithFormat:@"delete from %@",tableName];
        BOOL result = [self.db executeUpdate:sqlStr];
        if (result) {
            
            NSLog(@"删除成功");
            [self.db close];
            return YES;
        }else {
            
            NSLog(@"删除失败");
            [self.db close];
            return NO;
        }
    }
    return NO;
    
    
    
    
}






@end
