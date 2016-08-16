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
#import "DataHandler.h"
#import "RealReachability.h"
#import "AppDelegate.h"
#import "Reachability.h"

#define KbackgroundColer ([UIColor colorWithRed:255/255.0 green:221/255.0 blue:255/255.0 alpha:1])

@interface FunnyController ()

@end

@interface FunnyController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

// 数据源

@property (nonatomic, strong) NSMutableArray *funList1;

@property (nonatomic, strong) NSMutableArray *funList2;

@property (nonatomic, strong) NSMutableArray *funList3;

@property (nonatomic, strong) UISegmentedControl *segmentControl;

@property (nonatomic, strong) UIButton *suspendBtn;

@property (nonatomic, strong) Reachability *reachability;


@end

@implementation FunnyController

#pragma mark -- 懒加载

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
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, SCREEN_HEIGHT - 133) style:0];
        
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    self.reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    [self.reachability startNotifier];
    [self simulateRequest];
    
    [self controllerSetting];
    
    [self.view addSubview:self.tableView];
    
    [self createSegmentedControl];
    
    [self createSuspendBtn];
    
    self.funList3 = [[DataHandler shareDataHandler] selectFromTable];
    
    
}

- (void)controllerSetting
{
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = KbackgroundColer;
    
    self.tableView.backgroundColor = KbackgroundColer;
    self.tabBarController.tabBar.barTintColor = KbackgroundColer;
}

#pragma mark -- 观察者执行的方法
- (void)reachabilityChanged:(NSNotification* )notification
{
    NSLog(@"netWork changed");
}


#pragma mark -- 状态切换后提示信息
- (void)showNotificationMessageWithStatus: (NSString *)status{

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"当前网络状态" message:status preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:alert animated:YES completion:nil];
    [self performSelector:@selector(dismiss:) withObject:alert afterDelay:2];
}


- (void)dismiss:(UIAlertController *)alert{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- 视图销毁的时候停止监听，移除通知
- (void)dealloc{
    [GLobalRealReachability stopNotifier];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)networkreachability
{
    if (self.reachability)
    {
        switch (self.reachability.currentReachabilityStatus) {
            case NotReachable:
                return NO;
                break;
            case ReachableViaWiFi:
                return YES;
                break;
            case ReachableViaWWAN:
                return YES;
            default:
                return NO;
                break;
        }
    }
    else
    {
        return NO;
    }
}

#pragma mark -- 判断当前网络状态

- (void)simulateRequest
{
    BOOL net = [self networkreachability];
    
    if (net)
    {
        NSLog(@"网络可用");
        [self getData];
    }
    else
    {
        self.funList1 = [[DataHandler shareDataHandler] selectFromTable];
        self.funList2 = [[DataHandler shareDataHandler] selectFromTable1];
        self.funList3 = self.funList1;
        self.funList3 = self.funList2;
        NSLog(@"网络不可用");
    }
}



//给cell添加动画
//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    //设置Cell的动画效果为3D效果
//    //设置x和y的初始值为0.1；
//    cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
//    //x和y的最终值为1
//    [UIView animateWithDuration:1 animations:^{
//        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
//    }];
//}


#pragma mark -- 创建分段控件SegmentControl
- (void)createSegmentedControl
{
    self.segmentControl = [[UISegmentedControl alloc] initWithItems:@[@"推荐漫画", @"热门漫画"]];
    
    self.segmentControl.frame = CGRectMake(-5, 0, SCREEN_WIDTH + 10, 30);
    
    self.segmentControl.selectedSegmentIndex = 0;
    
    self.segmentControl.tintColor = [UIColor brownColor];
    
    self.segmentControl.backgroundColor = [UIColor whiteColor];
    
    [self.segmentControl addTarget:self action:@selector(segmentControlAction:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:self.segmentControl];
    
    [self segmentControlAction:self.segmentControl];
}


#pragma mark -- 分段控件点击方法
- (void)segmentControlAction:(UISegmentedControl *)sg
{
    
    [self simulateRequest];
    self.tableView.contentOffset = CGPointMake(0, 0);
    
    [self toTop];
    if (sg.selectedSegmentIndex == 0) {
        self.funList3 = self.funList1;
    }
    if (sg.selectedSegmentIndex == 1) {
        self.funList3 = self.funList2;
    }
    
    [self.tableView reloadData];
}


#pragma mark -- 创建置顶按钮
- (void)createSuspendBtn
{
    self.suspendBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.suspendBtn.frame = CGRectMake(SCREEN_WIDTH - 40, SCREEN_HEIGHT - 160, 40, 40);
    
    self.suspendBtn.layer.cornerRadius = 20;
    
    self.suspendBtn.layer.borderWidth = 0.2;
    
    [self.suspendBtn setTitle:@"置顶" forState:UIControlStateNormal];
    self.suspendBtn.layer.masksToBounds = YES;
    
    [self.suspendBtn addTarget:self action:@selector(toTop) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.suspendBtn];
}


#pragma mark -- 按钮置顶方法
- (void)toTop
{
    // 快速停止正在滚动的视图
    CGPoint offset = CGPointMake(0, 0);
    (self.tableView.contentOffset.y > 0) ? offset.y-- : offset.y++;
    [self.tableView setContentOffset:offset animated:NO];
    
}

#pragma mark -- 滚动视图会调用的方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView) {
        if (self.tableView.contentOffset.y >= SCREEN_HEIGHT / 3) {
            self.suspendBtn.hidden = NO;
            
            [self.view bringSubviewToFront:self.suspendBtn];
        } else if (self.tableView.contentOffset.y < SCREEN_HEIGHT / 3) {
            self.suspendBtn.hidden = YES;
        }
    }  
}


#pragma mark -- 获取网络数据
- (void)getData
{
    [DownLoad dowmLoadWithUrl:FUNNYLIST postBody:FUNNYLISTPOST resultBlock:^(NSData *data) {
        if (data == nil) {
            return;
        }else
        {
            self.funList1 = nil;
            self.funList2 = nil;
            [[DataHandler shareDataHandler] dropTable];
            [[DataHandler shareDataHandler] dropTable1];
            
            [[DataHandler shareDataHandler] createTable1];
            [[DataHandler shareDataHandler] createTable];
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            NSArray *array = dict[@"data"][@"list"];
        
            for (NSDictionary *dic in array) {
                
                FunListModel *model = [[FunListModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                
                NSURL *url = [NSURL URLWithString:model.coverPic];
                if (url) {
                    if ([model.popular intValue] > 5000 ) {
                       
                        [self.funList1 addObject:model];
                        
                        [[DataHandler shareDataHandler] insertIntoTable:model];
                    }else
                    {
                        [self.funList2 addObject:model];
                        
                        [[DataHandler shareDataHandler] insertIntoTable1:model];

                    }
                }
                
            }
            [self sortedWith:self.funList1];
            [self sortedWith:self.funList2];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (self.segmentControl.selectedSegmentIndex == 0) {
                    self.funList3 = self.funList1;
                }if (self.segmentControl.selectedSegmentIndex == 1) {
                    self.funList3 = self.funList2;
                }
                
                [self.tableView reloadData];

            });
        }
    }];
}


#pragma mark -- 数组排序
- (void)sortedWith:(NSMutableArray *)array
{
    for (int i = 0; i < array.count - 1; i++) {
        for (int j = 0; j < array.count - 1 - i; j++) {
            FunListModel *model1 = array[j];
            FunListModel *model2 = array[j + 1];
            if ([model1.popular intValue] < [model2.popular intValue]) {
                FunListModel *tempModel = array[j];
                array[j] = array[j + 1];
                array[j + 1] = tempModel;
            }
        }
    }
    
}

#pragma mark -- 返回每个分区的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.funList3.count;
}

#pragma mark -- 显示cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FunListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"funlistcell"];
    
    FunListModel *model = self.funList3[indexPath.row];
    cell.listModel = model;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}


#pragma mark -- 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.f;
}


#pragma mark -- 选中cell会调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (self.reachability.currentReachabilityStatus == RealStatusViaWWAN || self.reachability.currentReachabilityStatus == RealStatusViaWiFi) {
        FunnyDetailViewController *funDetailVc = [[FunnyDetailViewController alloc] initWithNibName:@"FunnyDetailViewController" bundle:nil];
        
        FunListModel *model = self.funList3[indexPath.row];
        
        funDetailVc.model = model;
        
        funDetailVc.albumId = model.albumId;
        [self.navigationController pushViewController:funDetailVc animated:YES];
    }
    else
    {
        MBProgressHUD *hud = [[MBProgressHUD alloc] init];
        [self.view addSubview:hud];
        hud.labelText = @"网络不可用";
        [hud show:YES];
        
        [hud hide:YES afterDelay:2];
    }

}



#pragma mark -- 视图即将出现
- (void)viewWillAppear:(BOOL)animated
{
    
    self.navigationController.navigationBar.hidden = NO;
    
    [JFJumpToControllerManager shared].navigation.navigationBarHidden = YES;
    
    self.tabBarController.tabBar.hidden = NO;
    
    self.suspendBtn.hidden = YES;
    
    self.tableView.contentOffset = CGPointMake(0, 0);
  
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}


@end
