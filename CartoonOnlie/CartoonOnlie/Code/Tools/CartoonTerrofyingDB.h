//
//  CartoonTerrofyingDB.h
//  CartoonOnlie
//
//  Created by zhiling on 16/8/10.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TerrofyingModel;


@interface CartoonTerrofyingDB : NSObject

/**
 *  单例
 *
 *  @return
 */
+ (CartoonTerrofyingDB *)shareDataHandler;

/**
 *  添加数据
 *
 *  @param model
 */
- (void)terrofyingModel:(TerrofyingModel *)model;

/**
 *  获取数去
 *
 *  @return 
 */
- (NSArray *)allModel;

/**
 *  清除数据
 */
- (BOOL)deleteModel;


@end
