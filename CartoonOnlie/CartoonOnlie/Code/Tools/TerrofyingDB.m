//
//  TerrofyingDB.m
//  CartoonOnlie
//
//  Created by zhiling on 16/8/8.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "TerrofyingDB.h"
#import "DBManager.h"
@implementation TerrofyingDB

//创建表格
- (void)createtable:(NSString *)tableN{
    
    DBManager *dbM = [DBManager shareInstance];
    if ([dbM.db open]) {
        
        [dbM.db executeUpdate:@"create table if not exists terrofying(title text not null)"];
        
    }
    
    [dbM.db close];
    
}

//添加数据
- (void)insertIntoTable:(NSString *)title imgStr:(NSString *)imgStr{
    NSLog(@"%@", title);
    DBManager *dbM = [DBManager shareInstance];
    [dbM.db open];
  
    [dbM.db executeUpdate:@"insert into terrofying values(?, ?)",title, imgStr];
    
    [dbM.db close];
    
}

//查找数据
- (NSMutableArray *)selectFormTable {
    
    NSMutableArray *arr = [NSMutableArray array];
    DBManager *dbM = [DBManager shareInstance];
    
    [dbM.db open];
    
    FMResultSet *set = [dbM.db executeQuery:@"select * from terrofying"];
    
    while ([set next]) {
        
        NSString *s = [set stringForColumnIndex:0];
        [arr addObject:s];
        
        
    }
    [dbM.db close];
    
    
    
    return arr;
}
- (void)deleteData {
    DBManager *dbM = [DBManager shareInstance];
    [dbM.db open];
    
    [dbM.db executeUpdate:@"DELETE FROM terrofying"];
    
    [dbM.db close];

}


@end
