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

@interface HMLeftMenuTableViewController ()<UMSocialUIDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation HMLeftMenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"22");

    
//    [user setValue:self.usernameT.text forKey:@"userName"];
//    [user setValue:self.passwordT.text forKey:@"passWork"];

    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *s = [user valueForKey:@"passWork"];
    if (s) {
        
        [self addCancelBtn];
    }else {
        
        [self addLoginBtn];
    }
    
    
}
- (void)getData {
    
    
    
    
    
    
    
}

- (void)addCancelBtn {
    
    self.tableView.separatorStyle = UITableViewCellAccessoryNone;
    //    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ll1.jpg"]];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 100)];
    headerView.backgroundColor = [UIColor magentaColor];
    //    headerView.userInteractionEnabled = YES;
    
    UIButton *addBtn  = [[UIButton alloc] initWithFrame:CGRectMake(30, 30, 80, 30)];
    [addBtn setTitle:@"注销" forState:UIControlStateNormal];
    addBtn.backgroundColor = [UIColor lightGrayColor];
    //    addBtn.frame = CGRectMake(30, 30, 60, 30);
    [addBtn addTarget:self action:@selector(btnCancelClick) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:addBtn];
    
    
    self.tableView.tableHeaderView = headerView;
    
}

- (void)addLoginBtn {
    
    self.tableView.separatorStyle = UITableViewCellAccessoryNone;
    //    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ll1.jpg"]];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 100)];
    headerView.backgroundColor = [UIColor magentaColor];
    //    headerView.userInteractionEnabled = YES;
    
    UIButton *addBtn  = [[UIButton alloc] initWithFrame:CGRectMake(30, 30, 80, 30)];
    [addBtn setTitle:@"登陆" forState:UIControlStateNormal];
    addBtn.backgroundColor = [UIColor lightGrayColor];
    //    addBtn.frame = CGRectMake(30, 30, 60, 30);
    [addBtn addTarget:self action:@selector(btnLoginClick) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:addBtn];
    
    
    self.tableView.tableHeaderView = headerView;
    
}

- (void)btnLoginClick{
    
    
    
    LoginController *loginVC = [[LoginController alloc] initWithNibName:@"LoginController" bundle:nil];
    
    [self presentViewController:loginVC animated:YES completion:nil];
    
//    [[HMDrawerViewController shareDrawer] switchController:nav];
    
    
}
- (void)btnCancelClick{
    
    NSString*appDomain = [[NSBundle mainBundle]bundleIdentifier];

    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    


    [self addLoginBtn];
    
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}



- (NSMutableArray *)dataArray {
    
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] initWithObjects:@"当前版本",@"清除缓存", @"分享给朋友", @"浏览记录", nil];
    }
    return _dataArray;
    
}


#pragma mark -- 选中cell时触发的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        [UMSocialData defaultData].extConfig.title = @"分享的title";
        [UMSocialData defaultData].extConfig.qqData.url = @"http://baidu.com";
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:@"57a5423267e58ebd7000281e"
                                          shareText:@"友盟社会化分享让您快速实现分享等社会化功能，http://umeng.com/social"
                                         shareImage:[UIImage imageNamed:@"icon"]
                                    shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina]
                                           delegate:self];
        
        
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
