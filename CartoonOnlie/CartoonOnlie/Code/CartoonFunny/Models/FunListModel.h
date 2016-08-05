//
//  FunListModel.h
//  CartoonOnlie
//
//  Created by lanou on 16/7/30.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FunListModel : NSObject

@property (nonatomic, strong) NSString *coverPic;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) NSString *updateSize;

@property (nonatomic, strong) NSString *authorName;

@property (nonatomic, strong) NSString *author;

@property (nonatomic, strong) NSString *label;

@property (nonatomic, assign) NSNumber *collectNum;


@end