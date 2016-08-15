//
//  SingleDayAndNight.m
//  CartoonOnlie
//
//  Created by zhiling on 16/8/15.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "SingleDayAndNight.h"

@implementation SingleDayAndNight

+ (SingleDayAndNight *)shareSingle {
    
    static SingleDayAndNight *single = nil;
    @synchronized(self) {
        if (single == nil) {
            
            single = [[SingleDayAndNight alloc] init];
        }
    }
    
    return single;
    
    
    
}

@end
