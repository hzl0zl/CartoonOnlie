//
//  HMLeftMenuTableViewController.m
//  Demo_仿QQ抽屉效果
//
//  Created by zhiling on 16/7/9.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "HMLeftMenuTableViewController.h"
#import "HMDrawerViewController.h"
#import "LoginController.h"

@interface HMLeftMenuTableViewController ()

@end

@implementation HMLeftMenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addLeftBtn];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

    
    
}

- (void)addLeftBtn {
    
    self.tableView.separatorStyle = UITableViewCellAccessoryNone;
    //    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ll1.jpg"]];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 100)];
    headerView.backgroundColor = [UIColor whiteColor];
    //    headerView.userInteractionEnabled = YES;
    
    UIButton *addBtn  = [[UIButton alloc] initWithFrame:CGRectMake(30, 30, 120, 30)];
    [addBtn setTitle:@"登陆" forState:UIControlStateNormal];
    addBtn.backgroundColor = [UIColor lightGrayColor];
    //    addBtn.frame = CGRectMake(30, 30, 60, 30);
    [addBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:addBtn];
    
    
    self.tableView.tableHeaderView = headerView;
    
}

- (void)btnClick{
    
    
    
    LoginController *loginVC = [[LoginController alloc] initWithNibName:@"LoginController" bundle:nil];
    
    [self presentViewController:loginVC animated:YES completion:nil];
    
//    [[HMDrawerViewController shareDrawer] switchController:nav];
    
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 7;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.text = @"当前版本";
    
    return cell;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
