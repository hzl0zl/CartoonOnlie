//
//  DataHandler.h
//  CartoonOnlie
//
//  Created by lanou on 16/8/6.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"


@class CollectionModel;
@class FunListModel;

@interface DataHandler : NSObject

@property (nonatomic, strong) FMDatabase *db;

+ (DataHandler *)shareDataHandler;


/**
 *  添加收藏
 *
 *  @param model 漫画
 *
 *  @return 收藏结果
 */
- (BOOL)collectionCartoon:(FunListModel *)cartoon;

/**
 *  获取所有的收藏漫画
 *
 *  @return 漫画数组, 每个元素为FunListModel
 */
- (NSArray *)allCartoon;


// 删除漫画
- (BOOL)deleteCartoon:(CollectionModel *)cartoon;


// 创建表格
- (void)createTable:(NSString *)funlist;

// 添加数据
- (void)insertIntoTable:(FunListModel *)model;

// 查找数据
- (NSMutableArray *)selectFromTable;


// 更新数据
- (void)updateTable:(FunListModel *)model;

@end
