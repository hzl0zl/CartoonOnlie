//
//  DataHandler.h
//  CartoonOnlie
//
//  Created by lanou on 16/8/6.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CollectionModel;

@interface DataHandler : NSObject

+ (DataHandler *)shareDataHandler;


/**
 *  添加收藏
 *
 *  @param model 漫画
 *
 *  @return 收藏结果
 */
- (BOOL)collectionCartoon:(CollectionModel *)cartoon;

/**
 *  获取所有的收藏漫画
 *
 *  @return 漫画数组, 每个元素为FunListModel
 */
- (NSArray *)allCartoon;


// 删除漫画
- (BOOL)deleteCartoon:(CollectionModel *)cartoon;



@end
