//
//  DBManager.h
//  iOS_PianKe
//
//  Created by zhiling on 16/7/29.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>
@interface DBManager : NSObject

@property (nonatomic, strong) FMDatabase *db;
//单例
+ (DBManager *)shareInstance;

@end
