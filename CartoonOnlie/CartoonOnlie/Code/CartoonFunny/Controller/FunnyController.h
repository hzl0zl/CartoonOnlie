//
//  FunnyController.h
//  CartoonOnlie
//
//  Created by zhiling on 16/7/30.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionModel.h"


@interface FunnyController : UIViewController

@property (nonatomic, strong) CollectionModel *model;

- (BOOL)networkreachability;

@end
