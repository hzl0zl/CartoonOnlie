//
//  TerrListModel.m
//  CartoonOnlie
//
//  Created by zhiling on 16/8/4.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "TerrListModel.h"

@implementation TerrListModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"id"]) {
        
        self.showID = [NSString stringWithFormat:@"%@", value];
        
    }
    
    
}

@end
