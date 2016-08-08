//
//  QuadraticMainModel.m
//  CartoonOnlie
//
//  Created by lanou on 16/8/5.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "QuadraticMainModel.h"

@implementation QuadraticMainModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"id"]) {
        
        self.ids = [NSString stringWithFormat:@"%@", value];
        
    }
    
    
}

@end
