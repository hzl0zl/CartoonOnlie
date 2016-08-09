//
//  DataHandler.m
//  CartoonOnlie
//
//  Created by lanou on 16/8/6.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "DataHandler.h"
#import "CollectionModel.h"
#import "CollectionModel.h"
#import "FMDB.h"

@interface DataHandler ()

@property (nonatomic, strong) FMDatabase *db;

@end
@implementation DataHandler

// 获取数据库路径
- (NSString *)dataBasePath
{
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *path = [doc stringByAppendingPathComponent:@"collection.sqlite"];
    NSLog(@"%@", path);
    
    return path;
}


// 初始化并创建数据库和数据表
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.db = [FMDatabase databaseWithPath:[self dataBasePath]];
        if ([self.db open]) {
            [self.db executeUpdate:@"create table if not exists cartoon(c_id integer primary key, c_albumId text, c_name text, c_coverPic text, c_descriptions text)"];
        }
        [self.db close];
    }
    return self;
}

// 创建单例
+(DataHandler *)shareDataHandler
{
    static DataHandler *dataHandler = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        dataHandler = [[DataHandler alloc] init];
    });
    
    return dataHandler;
}


// 往数据库添加数据
- (BOOL)collectionCartoon:(CollectionModel *)cartoon
{
    if ([self.db open]) {
        BOOL result = [self.db executeUpdate:@"insert into cartoon(c_albumId, c_name, c_coverPic, c_descriptions) values(?, ?, ?, ?)", cartoon.albumId, cartoon.name, cartoon.coverPic, cartoon.descriptions];
        [self.db close];
        return result;
    }
    [self.db close];
    return NO;
}

// 删除漫画
- (BOOL)deleteCartoon:(CollectionModel *)cartoon
{
    if ([self.db open]) {
        [self.db executeUpdate:@"delete from cartoon where c_name = ?", cartoon.name];
        [self.db close];
        return YES;
    }
    [self.db close];
    return NO;
}


// 查询整个数据表
- (NSArray *)allCartoon
{
    if ([self.db open]) {
        NSMutableArray *mArray = [[NSMutableArray alloc] init];
        FMResultSet *resultSet = [self.db executeQuery:@"select * from cartoon"];
        while ([resultSet next]) {
            CollectionModel *model = [[CollectionModel alloc] init];
            model.name = [resultSet stringForColumn:@"c_name"];
            model.coverPic = [resultSet stringForColumn:@"c_coverPic"];
            model.descriptions = [resultSet stringForColumn:@"c_descriptions"];
            
            model.albumId = [resultSet stringForColumn:@"c_albumId"];
            
            [mArray addObject:model];
        }
        [self.db close];
        return [mArray copy];
    }
    [self.db close];
    return nil;
}

@end
