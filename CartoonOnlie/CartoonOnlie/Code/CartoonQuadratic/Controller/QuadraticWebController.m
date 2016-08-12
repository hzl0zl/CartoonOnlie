//
//  QuadraticWebController.m
//  CartoonOnlie
//
//  Created by lanou on 16/8/5.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "QuadraticWebController.h"
@interface QuadraticWebController ()



@end

@implementation QuadraticWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatWebView];
}

-(void)creatWebView
{
    UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-60)];
    
    [self.view addSubview:web];
    
    NSURL * url1 = [NSURL URLWithString:self.model_url];
    
    NSURLRequest * request1 = [NSURLRequest requestWithURL:url1];
    
    [web loadRequest:request1];
 
}



@end
