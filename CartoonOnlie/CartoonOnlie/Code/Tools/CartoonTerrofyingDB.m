 //
//  CartoonTerrofyingDB.m
//  CartoonOnlie
//
//  Created by zhiling on 16/8/10.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "CartoonTerrofyingDB.h"
#import "TerrofyingModel.h"
#import "FMDB.h"

@interface CartoonTerrofyingDB ()

@property (nonatomic, strong) FMDatabase *db;

@end
@implementation CartoonTerrofyingDB

- (NSString *)dataBasePath {
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSLog(@"%@", path);
    
    NSString *createPath = [NSString stringWithFormat:@"%@/sqlFile", path];
    //    NSString *createDir = [NSString stringWithFormat:@""]
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    // 判断文件夹是否存在，如果不存在，则创建
    if (![[NSFileManager defaultManager] fileExistsAtPath:createPath]) {
        [fileManager createDirectoryAtPath:createPath withIntermediateDirectories:YES attributes:nil error:nil];
        //        [fileManager createDirectoryAtPath:createDir withIntermediateDirectories:YES attributes:nil error:nil];
    } else {
        NSLog(@"FileDir is exists.");
    }
    
    path = [createPath stringByAppendingPathComponent:@"Terrofying.sqlite"];
    return path;
    
}
- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.db = [FMDatabase databaseWithPath:[self dataBasePath]];
        
        if ([self.db open]) {
            
            [self.db executeUpdate:@"create table if not exists terrofying(n_id integer primary key, n_title text, n_picUrl text, n_shotdesc text);"];
        }
        
        [self.db close];
        
        
    }
    return self;
}

+ (CartoonTerrofyingDB *)shareDataHandler {
    
    
    static CartoonTerrofyingDB *dataHandler = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        dataHandler = [[CartoonTerrofyingDB alloc] init];
    });
   
    return dataHandler;
}


- (void)terrofyingModel:(TerrofyingModel *)model {
    
    if ([self.db open]) {
        NSLog(@"打开数据库开始存储数据");
        
//        NSString *str = [NSString stringWithFormat:@""];
        
        [self.db executeUpdate:@"insert into terrofying(n_title, n_picUrl, n_shotdesc) values (?, ?, ?); ", model.name, model.cover, model.shotdesc];
        
        
        [self.db close];
        
    }
    [self.db close];
    
}

- (NSArray *)allModel {
    
    if ([self.db open]) {
        
        NSMutableArray *mArray = [[NSMutableArray alloc] init];
        
        FMResultSet *resultSet = [self.db executeQuery:@"select * from terrofying"];
        
        while ([resultSet next]) {
            
            TerrofyingModel *model = [[TerrofyingModel alloc] init];
            model.name = [resultSet stringForColumn:@"n_title"];
            model.cover = [resultSet stringForColumn:@"n_picUrl"];
            model.shotdesc = [resultSet stringForColumn:@"n_shotdesc"];
        [mArray addObject:model];
            
        }
        [self.db close];
        return [mArray copy];
    }
    return nil;
}


- (BOOL)deleteModel {
    
    
    if ([self.db open]) {
        
        BOOL result = [self.db executeUpdate:@"delete from terrofying"];
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
