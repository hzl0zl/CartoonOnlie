//
//  CollectionController.m
//  CartoonOnlie
//
//  Created by lanou on 16/8/6.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "CollectionController.h"
#import "CollectionCell.h"
#import "DataHandler.h"
#import "CollectionModel.h"
#import "FunnyDetailViewController.h"

@interface CollectionController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation CollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"收藏夹";
    
    UINib *nib = [UINib nibWithNibName:@"CollectionCell" bundle:nil];
    
    [self.tableView registerNib:nib forCellReuseIdentifier:@"collectioncell"];
    
    
    [self createRightBtn];
}

- (void)createRightBtn
{
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"返回首页" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    
    self.navigationItem.rightBarButtonItem = rightBtn;
}


- (void)backAction
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.f;
}

// 视图即将出现
- (void)viewWillAppear:(BOOL)animated
{
    
    self.tabBarController.tabBar.hidden = YES;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.dataArray = [NSMutableArray arrayWithArray:[[DataHandler shareDataHandler] allCartoon]];
    
    [self.tableView reloadData];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"collectioncell" forIndexPath:indexPath];
    
    CollectionModel *model = self.dataArray[indexPath.row];
    
    cell.model = model;
    return cell;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CollectionModel *model = self.dataArray[indexPath.row];
    
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[DataHandler shareDataHandler] deleteCartoon:model];
        
        [self.dataArray removeObject:model];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    }
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FunnyDetailViewController *funDetailVc = [[FunnyDetailViewController alloc] initWithNibName:@"FunnyDetailViewController" bundle:nil];
    
    funDetailVc.model = self.dataArray[indexPath.row];
    
    CollectionModel *model = self.dataArray[indexPath.row];
    
    funDetailVc.albumId = @([model.albumId intValue]);
    [self.navigationController pushViewController:funDetailVc animated:YES];

}



@end
