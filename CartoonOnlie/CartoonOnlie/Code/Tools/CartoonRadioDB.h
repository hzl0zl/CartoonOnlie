//
//  CartoonRadioDB.h
//  CartoonOnlie
//
//  Created by zhiling on 16/8/10.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RadioModel;

@interface CartoonRadioDB : NSObject

/**
 *  单例
 *
 *  @return
 */
+ (CartoonRadioDB *)shareDataHandler;

/**
 *  创建数据库
 *
 *  @param name
 */
- (void)createTableWithName:(NSString *)name;

/**
 *  添加数据
 *
 *  @param model
 */
- (void)RadioModelModelWithTableName:(NSString *)tableName model:(RadioModel *)model;

/**
 *  获取数去
 *
 *  @return
 */
- (NSArray *)allModelWithTableName:(NSString *)tableName;

/**
 *  清除数据
 */
- (BOOL)deleteModelWithTableName:(NSString *)tableName;


@end
