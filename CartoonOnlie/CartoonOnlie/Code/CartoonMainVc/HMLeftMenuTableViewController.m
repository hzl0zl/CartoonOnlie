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
#import "UMSocial.h"
#import "MBProgressHUD.h"
#import "CleanCaches.h"
#import "SwitchCell.h"
#import "CoverView.h"
#import "AppDelegate.h"
#import "CollectionController.h"

BOOL isLogin;
@interface HMLeftMenuTableViewController ()<UMSocialUIDelegate>


{
    UIView *view;
}

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UISwitch *mySwitch;

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) UIButton *addBtn;

@end

@implementation HMLeftMenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]]];
    
    self.view.frame = [UIScreen mainScreen].bounds;
    
    UIView *view1 = [[UIView alloc] init];
    
    self.tableView.tableFooterView = view1;
    
    [self.tableView setScrollEnabled:NO];


    UINib *nib = [UINib nibWithNibName:@"SwitchCell" bundle:nil];
    
    [self.tableView registerNib:nib forCellReuseIdentifier:@"switchCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor clearColor];

    view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.alpha = 0.5;
    view.userInteractionEnabled = NO;
    [[JFJumpToControllerManager shared].navigation.view addSubview:view];
    
    [self setBtn];
    
    
}


#pragma mark app即将出现
- (void)viewWillAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *s = [user valueForKey:@"passWork"];
    if (s) {
        isLogin = YES;
        [self.addBtn setTitle:@"注销" forState:UIControlStateNormal];
    }else
    {
        
        [self.addBtn setTitle:@"登录/注册" forState:UIControlStateNormal];
        isLogin = NO;
    }
}



#pragma mark -- 个人设置页面
- (void)setBtn {
    
    
    self.tableView.separatorColor = [UIColor blackColor];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 150)];
  
    UIView *view2 =[[UIView alloc]initWithFrame:CGRectMake(15, 149, SCREEN_WIDTH-15, 1)];
    
    view2.backgroundColor = [UIColor blackColor];
    
    [headerView addSubview:view2];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"088"]];
    
    
    imageView.layer.borderWidth = 1;
    
    imageView.layer.borderColor = [UIColor blackColor].CGColor;
    
    imageView.layer.masksToBounds  = YES;
    
    imageView.layer.cornerRadius = 40;
    
    imageView.frame = CGRectMake(SCREEN_WIDTH / 2 - 40,25, 80, 80);
    

    
    [headerView addSubview:imageView];
    
    self.addBtn  = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 50, 110, 100, 30)];
    
    [self.addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.tableView.tableHeaderView = headerView;
    
    [self.addBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:self.addBtn];
    
}

#pragma mark -- 按钮点击方法
- (void)btnClick
{
    if (isLogin == NO) {
        LoginController *loginVC = [[LoginController alloc] initWithNibName:@"LoginController" bundle:nil];
        
        [self presentViewController:loginVC animated:YES completion:nil];        
        
    }else if(isLogin == YES)
    {
        NSString*appDomain = [[NSBundle mainBundle]bundleIdentifier];
        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
        [self.addBtn setTitle:@"登录/注册" forState:UIControlStateNormal];
        isLogin = NO;
    }
}


#pragma mark 返回行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}


#pragma mark 返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        SwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"switchCell"];
        
        [cell.dnSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        
        cell.backgroundColor = [UIColor clearColor];
        
 
        return cell;
        
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.text = self.dataArray[indexPath.section];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    

    cell.backgroundColor = [UIColor clearColor];
    
    self.tableView.tableHeaderView.backgroundColor = [UIColor clearColor];
    
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    return cell;
}

- (void)switchAction:(UISwitch *)sender
{
    if (sender.isOn == YES) {
        view.backgroundColor = [UIColor clearColor];
        [CoverView shareCoverView].isDarkTheme = YES;
    }else
    {
        view.backgroundColor = [UIColor grayColor];
        view.alpha = 0.5;
        
        [CoverView shareCoverView].isDarkTheme = NO;
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"switchChange" object:nil userInfo:nil];
}

#pragma mark 返回分区
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
 
    return 5;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

#pragma mark 初始化
- (NSMutableArray *)dataArray {
    
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] initWithObjects:@"夜间模式", @"我的收藏", @"清除缓存", @"分享给朋友", @"当前版本", nil];
    }
    return _dataArray;
    
}





#pragma mark 新浪
- (void)shareSina {
    [UMSocialData defaultData].extConfig.title = @"分享的title";
    [UMSocialData defaultData].extConfig.qqData.url = @"http://baidu.com";
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"57a5423267e58ebd7000281e"
                                      shareText:@"友盟社会化分享让您快速实现分享等社会化功能，http://umeng.com/social"
                                     shareImage:[UIImage imageNamed:@"icon"]
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina]
                                       delegate:self];
    
    
}


#pragma mark -- 选中cell时触发的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        CollectionController *collectionVc = [[CollectionController alloc] initWithNibName:@"CollectionController" bundle:nil];
        
        [self.navigationController pushViewController:collectionVc animated:YES];
    }
    
    if (indexPath.section == 3) {
        [self shareSina];
    }
    if (indexPath.section == 2) {
        
NSLog(@"23432423");

        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *path = [paths objectAtIndex:0];
        double aa = [CleanCaches sizeWithFilePath:path];
        NSString *str = [NSString stringWithFormat:@"当前缓存为%.1fMB 是否清空缓存", aa];
        
    
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:str preferredStyle:UIAlertControllerStyleAlert];
        
        [ alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            MBProgressHUD *hud = [[MBProgressHUD alloc] init];
            [self.view addSubview:hud]; 
            //加载条上显示文本
            hud.labelText = @"正在玩命清理中";
            //设置对话框样式
            hud.mode = MBProgressHUDModeDeterminate;
            [hud showAnimated:YES whileExecutingBlock:^{
                while (hud.progress < 1.0) {
                    hud.progress += 0.01;
                    [NSThread sleepForTimeInterval:0.02];
                }
                hud.labelText = @"清理完成";
            } completionBlock:^{
                //清除本地
                //清除caches文件下所有文件
                [CleanCaches clearSubfilesWithFilePath:[CleanCaches CachesDirectory]];
                //清除内存
                [[SDImageCache sharedImageCache] clearMemory];
                [self.tableView reloadData];
                [hud removeFromSuperview];
            }];
            
            
        } ]];
        
        [ alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        } ]];
        
        [self presentViewController:alert animated:true completion:nil];
        
        
        
    }
    if (indexPath.section == 4) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"当前版本号: v0.1" preferredStyle:UIAlertControllerStyleAlert];
        
        [ alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        } ]];
        
        [ alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        } ]];
        
        [self presentViewController:alert animated:true completion:nil];
 
    }
    
    
}


#pragma mark -- 协议代理方法
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的平台名
        NSLog(@"分享成功");
    }
}



@end
