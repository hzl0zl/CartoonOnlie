//
//  FunListModel.h
//  CartoonOnlie
//
//  Created by lanou on 16/7/30.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FunListModel : NSObject

@property (nonatomic, strong) NSString *url;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, assign) NSString *volumecount;

@property (nonatomic, assign) BOOL updateflag;

@property (nonatomic, strong) NSString *painter;

@property (nonatomic, strong) NSString *writer;

@property (nonatomic, assign) NSString *score;

@end
