//
//  TerrofyingModel.m
//  CartoonOnlie
//
//  Created by zhiling on 16/7/30.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "TerrofyingModel.h"

@implementation TerrofyingModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"id"]) {
        
        self.ids = [NSString stringWithFormat:@"%@", value];
        
    }
    
    
}


@end
