//
//  HMLeftMenuTableViewController.m
//  Demo_仿QQ抽屉效果
//
//  Created by zhiling on 16/7/9.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "HMLeftMenuTableViewController.h"
#import "HMDrawerViewController.h"
#import "FunnyController.h"

@interface HMLeftMenuTableViewController ()

@end

@implementation HMLeftMenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellAccessoryNone;
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ll1.jpg"]];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 200)];
    headerView.backgroundColor = [UIColor whiteColor];
//    headerView.userInteractionEnabled = YES;
    
    UIButton *addBtn  = [[UIButton alloc] initWithFrame:CGRectMake(30, 30, 120, 30)];
    [addBtn setTitle:@"跳转到有趣的页面" forState:UIControlStateNormal];
    addBtn.backgroundColor = [UIColor lightGrayColor];
//    addBtn.frame = CGRectMake(30, 30, 60, 30);
    [addBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:addBtn];
    
    
    self.tableView.tableHeaderView = headerView;
    
    
}

- (void)btnClick{
//    NSLog(@"点击了");
    FunnyController *vc = [[FunnyController alloc] init];
    vc.view.backgroundColor = [UIColor magentaColor];
    
    vc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fanli.png"] style:UIBarButtonItemStyleDone target:[HMDrawerViewController shareDrawer] action:@selector(backHome)];
    
    vc.title  = @"搞笑段子";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    
    [[HMDrawerViewController shareDrawer] switchController:nav];
    
    
}










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
