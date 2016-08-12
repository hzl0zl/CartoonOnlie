//
//  QuadrticHander.h
//  CartoonOnlie
//
//  Created by lanou on 16/8/10.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import <Foundation/Foundation.h>
@class QuadraticModel;
@interface QuadrticHander : NSObject

//单例
+(QuadrticHander *)shareHandler;

//数据持久化保存
-(BOOL)saveData:(QuadraticModel *)modelData;

//查询所有数据
-(NSMutableArray *)allData;


@end
