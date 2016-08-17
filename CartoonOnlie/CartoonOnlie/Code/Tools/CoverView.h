//
//  CoverView.h
//  CartoonOnlie
//
//  Created by lanou on 16/8/17.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoverView : NSObject

+ (CoverView *)shareCoverView;

- (UIView *)createCoverView;

- (void)removeView;

@end
