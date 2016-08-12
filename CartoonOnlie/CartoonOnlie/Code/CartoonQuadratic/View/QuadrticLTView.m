//
//  QuadrticLTView.m
//  CartoonOnlie
//
//  Created by lanou on 16/8/8.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "QuadrticLTView.h"

@implementation QuadrticLTView

-(instancetype)initQuadrticLTViewWith:(CGRect)frame headerAndFoote:(NSString *)type
{
    
    
    if (self = [super initWithFrame:frame]) {
        
    if ([type isEqualToString:@"header"]) {
        
        self.type = [[UILabel alloc]initWithFrame:CGRectMake(15, 2.5, 45, 20 )];
      
        self.title = [[UILabel alloc]initWithFrame:CGRectMake(75, 2.5, 130, 20)];
        
        self.author = [[UILabel alloc]initWithFrame:CGRectMake(240, 2.5, 70, 20)];
     
        self.type.font = [UIFont systemFontOfSize:13];

        self.title.font = [UIFont systemFontOfSize:12];
        
        self.author.font = [UIFont systemFontOfSize:12];
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.type.layer.masksToBounds = YES;
        self.type.layer.borderWidth = 1;
  
        self.type.textAlignment = NSTextAlignmentCenter;
        self.type.layer.cornerRadius = 10;
        
        
        [self addSubview:self.title];
        [self addSubview:self.author];
        [self addSubview:self.type];
        return self;
        
    }else
    {
            self.title = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 150, 20)];
        
            self.title.font = [UIFont systemFontOfSize:12];
        
            self.backgroundColor = [UIColor whiteColor];
        
            [self addSubview:self.title];
        
            return self;
    }

    }
    
        
    return nil;
}

@end
