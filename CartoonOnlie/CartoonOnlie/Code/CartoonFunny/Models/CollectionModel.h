//
//  CollectionModel.h
//  CartoonOnlie
//
//  Created by lanou on 16/8/6.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectionModel : NSObject

@property (nonatomic, assign) NSNumber *albumId;

@property (nonatomic, strong) NSString *descriptions;


@property (nonatomic, strong) NSString *coverPic;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) NSNumber *updateSize;

@property (nonatomic, assign) NSNumber *updateTime;

@property (nonatomic, strong) NSString *author;

@property (nonatomic, strong) NSString *label;

@property (nonatomic, assign) NSNumber *status;

@property (nonatomic, assign) NSNumber *popular;



@end
