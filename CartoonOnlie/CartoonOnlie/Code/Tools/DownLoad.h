//
//  DownLoad.h
//  iOS_PianKe
//
//  Created by zhiling on 16/7/21.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^Block) (NSData *data);


@interface DownLoad : NSObject

+ (void)dowmLoadWithUrl:(NSString *)urls postBody:(NSString *)postBody resultBlock:(Block)resultBlock;

@end