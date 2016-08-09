//
//  QuadriticCellModel.h
//  CartoonOnlie
//
//  Created by lanou on 16/8/8.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuadriticCellModel : NSObject

//图片
@property (nonatomic,strong) NSString *cover_image_url;

//标题
@property (nonatomic,strong) NSString *title;

//时间
@property (nonatomic,strong) NSNumber *created_at;

//内容
@property (nonatomic,strong) NSString *url;



@end
