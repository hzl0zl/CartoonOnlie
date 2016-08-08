//
//  PicWebController.m
//  CartoonOnlie
//
//  Created by zhiling on 16/8/8.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "PicWebController.h"

@interface PicWebController ()

@end

@implementation PicWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatWebView];
}


-(void)creatWebView
{
    UIWebView *web = [[UIWebView alloc]initWithFrame:self.view.bounds];
    
    [self.view addSubview:web];
    
    
    //属性传值
//    QuadraticModel *model1 = self.model;
    
    NSURL * url = [NSURL URLWithString:self.urlStr];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    [web loadRequest:request];
    
    NSLog(@"$%@",request);
    web.backgroundColor = [UIColor redColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
