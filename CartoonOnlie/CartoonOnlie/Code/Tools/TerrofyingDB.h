//
//  TerrofyingDB.h
//  CartoonOnlie
//
//  Created by zhiling on 16/8/8.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TerrofyingDB : NSObject



//创建表格
- (void)createtable:(NSString *)tableN;

//添加数据
- (void)insertIntoTable:(NSString *)title imgStr:(NSString *)imgStr;

//查找数据
- (NSMutableArray *)selectFormTable;

//清空表中数据
- (void)deleteData;


@end
