//
//  CoverView.m
//  CartoonOnlie
//
//  Created by lanou on 16/8/17.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "CoverView.h"

@implementation CoverView

{
    UIView *view;
}

+ (CoverView *)shareCoverView
{
    static CoverView *coverView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        coverView = [[CoverView alloc] init];
    });
    return coverView;
}

- (UIView *)createCoverView
{
    view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor lightGrayColor];
    view.alpha = 0.3;
    
    return view;
}

- (void)removeView
{
    [view removeFromSuperview];
}

@end
