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
#import "SDCycleScrollView.h"
#import "FunnyDetailViewController.h"
#import "HMDrawerViewController.h"

@interface FunnyController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

// 数据源
@property (nonatomic, strong) NSMutableArray *funList;


@end



@implementation FunnyController



#pragma mark -- 懒加载

- (NSMutableArray *)funList

{
    
    if (_funList == nil) {
        
        _funList = [NSMutableArray array];
        
    }
    
    return _funList;
    
}



- (UITableView *)tableView

{
    
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 113) style:0];
        
        _tableView.delegate = self;
        
        _tableView.dataSource = self;
        
        UINib *nib = [UINib nibWithNibName:@"FunListCell" bundle:nil];
        
        [_tableView registerNib:nib forCellReuseIdentifier:@"funlistcell"];
        
    }
    
    return _tableView;
    
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(FunnyleftAction)];
    self.navigationController.navigationBar.translucent = NO;
    self.tableView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.tableView];
    
    [self getData];
    
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
                    [self.funList addObject:model];
                }
        
            }
            NSLog(@"%@", self.funList);
            
            FunListModel *model = self.funList[2];
            
            NSLog(@"%@", model.updateSize);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.tableView reloadData];
            });
        }
        
    }];
}


// 返回每个分区的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    return self.funList.count;
    
}

// 显示cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    FunListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"funlistcell"];
    
    FunListModel *model = self.funList[indexPath.row];
    
    cell.listModel = model;
    
    return cell;
    
}


// 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
//    return (SCREEN_HEIGHT - 113) / 600 * 150 ;
    return 120.f;
    
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FunnyDetailViewController *funDetailVc = [[FunnyDetailViewController alloc] initWithNibName:@"FunnyDetailViewController" bundle:nil];
    
    
    funDetailVc.model = self.funList[indexPath.row];
    
    [self.navigationController pushViewController:funDetailVc animated:YES];
}
- (void)FunnyleftAction {
    
    [[HMDrawerViewController shareDrawer] openLeftMenu];
    
    
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
