//
//  CoverView.m
//  CartoonOnlie
//
//  Created by lanou on 16/8/17.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "CoverView.h"

@implementation CoverView

+ (CoverView *)shareCoverView
{
    static CoverView *coverView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        coverView = [[CoverView alloc] init];
        coverView.isDarkTheme = YES;
    });
    return coverView;
}


@end
