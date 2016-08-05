//
//  FunnyController.m
//  CartoonOnlie
//
//  Created by zhiling on 16/7/30.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "FunnyController.h"
#import "FunListCell.h"
#import "FunListModel.h"
#import "FunnyDetailViewController.h"
#import "HMDrawerViewController.h"

@interface FunnyController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

// 数据源

@property (nonatomic, strong) NSMutableArray *funList1;

@property (nonatomic, strong) NSMutableArray *funList2;

@property (nonatomic, strong) NSMutableArray *funList3;

@property (nonatomic, strong) UISegmentedControl *segmentControl;


@end



@implementation FunnyController



#pragma mark -- 懒加载

//- (NSMutableArray *)funList
//{
//    if (_funList == nil) {
//        _funList = [NSMutableArray array];
//    }
//    return _funList;
//}

- (NSMutableArray *)funList1
{
    if (_funList1 == nil) {
        
        _funList1 = [NSMutableArray array];
        
    }
    return _funList1;
}

- (NSMutableArray *)funList2
{
    if (_funList2 == nil) {
        _funList2 = [NSMutableArray array];
    }
    return _funList2;
}

- (NSMutableArray *)funList3
{
    if (_funList3 == nil) {
        _funList3 = [NSMutableArray array];
    }
    return _funList3;
}

- (UITableView *)tableView
{
    
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, SCREEN_HEIGHT - 143) style:0];
        
        _tableView.delegate = self;
        
        _tableView.dataSource = self;
        
        UINib *nib = [UINib nibWithNibName:@"FunListCell" bundle:nil];
        
        [_tableView registerNib:nib forCellReuseIdentifier:@"funlistcell"];
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    
    return _tableView;
    
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(FunnyleftAction)];
    self.navigationController.navigationBar.translucent = NO;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    [self createSegmentedControl];
    
    [self getData];
    
    
}



// 创建分段控件SegmentControl
- (void)createSegmentedControl
{
    self.segmentControl = [[UISegmentedControl alloc] initWithItems:@[@"人气漫画", @"热门漫画"]];
    
    self.segmentControl.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
    
    self.segmentControl.selectedSegmentIndex = 0;
    
    [self.segmentControl addTarget:self action:@selector(segmentControlAction:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:self.segmentControl];
    
    [self segmentControlAction:self.segmentControl];
}

- (void)segmentControlAction:(UISegmentedControl *)sg
{
    if (sg.selectedSegmentIndex == 0) {
        self.funList3 = self.funList1;
    }else if(sg.selectedSegmentIndex == 1)
    {
        self.funList3 = self.funList2;
    }
    [self.tableView reloadData];
}



// 获取网络数据
- (void)getData
{
    [DownLoad dowmLoadWithUrl:FUNNYLIST postBody:FUNNYLISTPOST resultBlock:^(NSData *data) {
        if (data == nil) {
            return;
        }else
        {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            NSArray *array = dict[@"data"][@"list"];
        
            for (NSDictionary *dic in array) {
                
                FunListModel *model = [[FunListModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                
                NSURL *url = [NSURL URLWithString:model.coverPic];
                if (url) {
                    if ([model.popular intValue] > 5000) {
                        [self.funList1 addObject:model];
                    }else
                    {
                        [self.funList2 addObject:model];
                    }
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.tableView reloadData];
            });
        }
    }];
}


// 返回每个分区的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    return _funList3.count;
}

// 显示cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FunListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"funlistcell"];
    
    FunListModel *model = self.funList3[indexPath.row];
    cell.listModel = model;
    return cell;
}


// 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.f;
}


// 选中cell会调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FunnyDetailViewController *funDetailVc = [[FunnyDetailViewController alloc] initWithNibName:@"FunnyDetailViewController" bundle:nil];
    FunListModel *model = self.funList3[indexPath.row];
    
    funDetailVc.model = model;
    
    funDetailVc.albumId = model.albumId;
    
    [self.navigationController pushViewController:funDetailVc animated:YES];
}

- (void)FunnyleftAction {
    
    
     [[HMDrawerViewController shareDrawer] openLeftMenu];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}


@end
