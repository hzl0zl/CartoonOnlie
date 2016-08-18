//
//  DataHandler.m
//  CartoonOnlie
//
//  Created by lanou on 16/8/6.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "DataHandler.h"
#import "CollectionModel.h"
#import "FunListModel.h"

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
            [self.db executeUpdate:@"create table if not exists cartoon(c_id integer primary key, c_albumId text, c_name text, c_coverPic text, c_descriptions text, c_author text, c_updateTime text, c_status text, c_popular text)"];
            
            [self.db executeUpdate:@"create table if not exists funlist (f_name text not null, f_coverPic text, f_author text, f_label text, f_status text, f_updateSize text, f_popular text, f_albumId text, f_authorName text, f_updateTime text, f_descriptions text)"];
            
            [self.db executeUpdate:@"create table if not exists funlist1 (f_name text not null, f_coverPic text, f_author text, f_label text, f_status text, f_updateSize text, f_popular text, f_albumId text, f_authorName text, f_updateTime text, f_descriptions text)"];
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
- (BOOL)collectionCartoon:(FunListModel *)cartoon
{
    if ([self.db open]) {
        BOOL result = [self.db executeUpdate:@"insert into cartoon(c_albumId, c_name, c_coverPic, c_descriptions, c_author, c_updateTime, c_status, c_popular) values(?, ?, ?, ?, ?, ?, ?, ?)", cartoon.albumId, cartoon.name, cartoon.coverPic, cartoon.descriptions, cartoon.author, cartoon.updateTime, cartoon.status, cartoon.popular];
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
            
            model.albumId = @([[resultSet stringForColumn:@"c_albumId"] integerValue]);
            
            model.author = [resultSet stringForColumn:@"c_author"];
            model.updateTime = @([[resultSet stringForColumn:@"c_updateTime"] integerValue]);
            
            model.status = @([[resultSet stringForColumn:@"c_status"] integerValue]);
            
            model.popular = @([[resultSet stringForColumn:@"c_popular"] integerValue]);
            
            [mArray addObject:model];
        }
        [self.db close];
        return [mArray copy];
    }
    [self.db close];
    return nil;
}


// 添加数据
- (void)insertIntoTable:(FunListModel *)model
{
    [self.db open];
    
    [self.db executeUpdate:@"insert into funlist(f_name, f_coverPic, f_author, f_label, f_status, f_updateSize, f_popular, f_albumId, f_authorName, f_updateTime, f_descriptions) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", model.name, model.coverPic, model.author, model.label, model.status, model.updateSize, model.popular, model.albumId, model.authorName, model.updateTime, model.descriptions];
    
    [self.db close];
}

- (void)createTable
{
    [self.db open];
    [self.db executeUpdate:@"create table if not exists funlist (f_name text not null, f_coverPic text, f_author text, f_label text, f_status text, f_updateSize text, f_popular text, f_albumId text, f_authorName text, f_updateTime text, f_descriptions text)"];
    [self.db close];
}

// 查找数据
- (NSMutableArray *)selectFromTable
{
    NSMutableArray *array = [NSMutableArray array];
    
    [self.db open];
    FMResultSet *set = [self.db executeQuery:@"select * from funlist"];
    while ([set next]) {
        
        FunListModel *model = [[FunListModel alloc] init];
        model.name = [set stringForColumn:@"f_name"];
        
        model.coverPic = [set stringForColumn:@"f_coverPic"];
        
        model.author = [set stringForColumn:@"f_author"];
        
        model.label = [set stringForColumn:@"f_label"];
        
        model.status = @([[set stringForColumn:@"f_status"] integerValue]);
        
        model.updateSize = @([[set stringForColumn:@"f_updateSize"] integerValue]);
        
        model.popular = @([[set stringForColumn:@"f_popular"] integerValue]);
        
        model.albumId = @([[set stringForColumn:@"f_albumId"] integerValue]);
        
        model.authorName = [set stringForColumn:@"f_authorName"];
        
        model.updateTime = @([[set stringForColumn:@"f_updateTime"] integerValue]);
        
        model.descriptions = [set stringForColumn:@"f_descriptions"];
        
        
        [array addObject:model];
        
    }
    
    [self.db close];
    return array;
}
// 添加数据
- (void)insertIntoTable1:(FunListModel *)model
{
    [self.db open];
    
    [self.db executeUpdate:@"insert into funlist1(f_name, f_coverPic, f_author, f_label, f_status, f_updateSize, f_popular, f_albumId, f_authorName, f_updateTime, f_descriptions) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", model.name, model.coverPic, model.author, model.label, model.status, model.updateSize, model.popular, model.albumId, model.authorName, model.updateTime, model.descriptions];
    
    [self.db close];
}

- (void)createTable1
{
    [self.db open];
    [self.db executeUpdate:@"create table if not exists funlist1 (f_name text not null, f_coverPic text, f_author text, f_label text, f_status text, f_updateSize text, f_popular text, f_albumId text, f_authorName text, f_updateTime text, f_descriptions text)"];
    [self.db close];
}

// 查找数据
- (NSMutableArray *)selectFromTable1
{
    NSMutableArray *array = [NSMutableArray array];
    
    [self.db open];
    FMResultSet *set = [self.db executeQuery:@"select * from funlist1"];
    while ([set next]) {
        
        FunListModel *model = [[FunListModel alloc] init];
        model.name = [set stringForColumn:@"f_name"];
        
        model.coverPic = [set stringForColumn:@"f_coverPic"];
        
        model.author = [set stringForColumn:@"f_author"];
        
        model.label = [set stringForColumn:@"f_label"];
        
        model.status = @([[set stringForColumn:@"f_status"] integerValue]);
        
        model.updateSize = @([[set stringForColumn:@"f_updateSize"] integerValue]);
        
        model.popular = @([[set stringForColumn:@"f_popular"] integerValue]);
        
        model.albumId = @([[set stringForColumn:@"f_albumId"] integerValue]);
        
        model.authorName = [set stringForColumn:@"f_authorName"];
        
        model.updateTime = @([[set stringForColumn:@"f_updateTime"] integerValue]);
        
        model.descriptions = [set stringForColumn:@"f_descriptions"];
        
        
        [array addObject:model];
        
    }
    
    [self.db close];
    return array;
}

- (void)updateTable:(FunListModel *)model
{
    [self.db open];
    [self.db executeUpdate:[NSString stringWithFormat:@"update funlist set f_coverPic = \'%@\', f_author = \'%@\', f_label = \'%@\', f_status = \'%@\', f_updateSize = \'%@\', f_popular = \'%@\', f_albumId = \'%@\', f_authorName = \'%@\', f_updateTime = \'%@\', f_descriptions = \'%@\' WHERE f_name = \'%@\'", model.coverPic, model.author, model.label, model.status, model.updateSize, model.popular, model.albumId, model.authorName, model.updateTime, model.descriptions, model.name]];
    [self.db close];
}

// 删除表
- (void)dropTable
{
    [self.db open];
    [self.db executeUpdate:@"drop table funlist"];
    [self.db close];
}

- (void)dropTable1
{
    [self.db open];
    [self.db executeUpdate:@"drop table funlist1"];
    [self.db close];
}

@end
