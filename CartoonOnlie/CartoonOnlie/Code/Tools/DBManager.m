//
//  DBManager.m
//  iOS_PianKe
//
//  Created by zhiling on 16/7/29.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "DBManager.h"

@interface DBManager ()




@end

@implementation DBManager

+ (DBManager *)shareInstance {
    
//    static
    static dispatch_once_t onceToken;
    static DBManager *db;
    
    dispatch_once(&onceToken, ^{
        
        db = [[DBManager alloc] init];
    });
    return db;
}

- (instancetype)init {
    if (self = [super init]) {
        
        NSString *s = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        
        NSString *path = [s stringByAppendingString:@"/Pianke.sqlite"];
        NSLog(@"%@", path);
        self.db = [FMDatabase databaseWithPath:path];
        
        
    }
    
    
    return self;
}

@end
