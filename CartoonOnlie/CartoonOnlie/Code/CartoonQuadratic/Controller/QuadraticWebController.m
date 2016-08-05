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
    UIWebView *web = [[UIWebView alloc]initWithFrame:self.view.bounds];
    
    [self.view addSubview:web];
    
   
    //属性传值
    QuadraticModel *model1 = self.model;
    
    NSURL * url = [NSURL URLWithString:model1.url];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    [web loadRequest:request];
    
     NSLog(@"$%@",request);
   web.backgroundColor = [UIColor redColor];
}
-(void)loadData
{
    
  
}


@end
