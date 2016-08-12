//
//  MYHint.m
//  YiZhangTong
//
//  Created by WangKun on 14-5-20.
//  Copyright (c) 2014年 WangKun. All rights reserved.
//

#import "MYHint.h"

@implementation MYHint

- (id)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor grayColor];
        self.textColor = [UIColor whiteColor];
        self.textAlignment = NSTextAlignmentCenter;
        self.layer.borderColor = [UIColor darkGrayColor].CGColor;
        self.layer.borderWidth = 1.0;
        self.layer.cornerRadius = 1.0;
        self.alpha = 0.7;
    }
    
    return self;
}

- (void)showInView:(UIView *)view
{
    self.frame = CGRectMake(view.frame.size.width/2 - 75.0, view.frame.size.height/2 - 32, 150.0, 30.0);
    [view addSubview:self];
    
    [NSThread detachNewThreadSelector:@selector(dismiss) toTarget:self withObject:nil];
}

- (void)dismiss
{
    @autoreleasepool {
        sleep(1);
        [self removeFromSuperview];
    }
}


@end
