//
//  QuadraticController.m
//  CartoonOnlie
//
//  Created by zhiling on 16/7/30.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "QuadraticController.h"
#import "HMDrawerViewController.h"
@interface QuadraticController ()

@end

@implementation QuadraticController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor magentaColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(leftAction)];
    
}


- (void)leftAction {
    
    [[HMDrawerViewController shareDrawer] openLeftMenu];
    
    
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