//
///Users/lan/Desktop/CartoonOnlie/CartoonOnlie/CartoonOnlie/CartoonOnlie/Code/CartoonQuadratic/Controller/QuadrticCellController.h  RadioDetailVC.m
//  CartoonOnlie
//
//  Created by zhiling on 16/8/13.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "RadioDetailVC.h"
//#import "QScalableNav.h"
#import "RadioDetaiModel.h"
#import "RadioDetailCell.h"
#import "AudioPlayerController.h"
#import "MusicModel.h"


#import "UIViewController+NavBarHidden.h"

@interface RadioDetailVC () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArr;



@end
static NSString *const kCellID = @"radioDetailCell";
@implementation RadioDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];


        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"06"]style:UIBarButtonItemStyleDone target:self action:@selector(RadioRightAction)];
    

    
        self.tableView.frame = self.view.bounds;


    
    [self getData];

    
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
    
}
-(void)viewDidLayoutSubviews
{
    NSLog(@"11111");

}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AudioPlayerController *playVC = [AudioPlayerController audioPlayerController];
    
    playVC.imageStr = self.radioModel.wiki_cover[@"large"];
    [playVC initWithArray:self.dataArr index:indexPath.row];
//    NSLog(@"%@", self.radioModel.wiki_cover[@"small"]);
    [self presentViewController:playVC animated:YES completion:nil];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RadioDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    
    MusicModel *model = self.dataArr[indexPath.row];
    
    cell.radioDetailModel = model;
    cell.imageStr = self.radioModel.wiki_cover[@"large"];
    
    return cell;
}

- (NSMutableArray *)dataArr {
    
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    
    return _dataArr;
    
}
- (void)getData {
    //    NSString *url = @"http://moe.fm/listen/playlist?api=json&api_key=74915edacd1a54b1157833bb952f64a5055b78cdc&page=1&perpage=30&radio=45835";
    MBProgressHUD *hud = [[MBProgressHUD alloc] init];
    [self.view addSubview:hud];
    hud.labelText = @"努力加载中";
    [hud show:YES];
    NSString *url = [NSString stringWithFormat:@"http://moe.fm/listen/playlist?api=json&api_key=74915edacd1a54b1157833bb952f64a5055b78cdc&page=1&perpage=30&radio=%@", self.radioModel.wiki_id];
    
    [DownLoad dowmLoadWithUrl:url postBody:nil resultBlock:^(NSData *data) {
        if (data != nil) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@", dict);
            NSArray *arr = dict[@"response"][@"playlist"];
            
            for (NSDictionary *dict1 in arr) {
                
                MusicModel *model = [[MusicModel alloc] init];
                
                [model setValuesForKeysWithDictionary:dict1];
                
                [self.dataArr addObject:model];
            }
            
            NSLog(@"%@", self.dataArr);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud removeFromSuperview];
                [self.tableView reloadData];
                
            });
            
        }else {
            hud.labelText = @"网络繁忙!!!";
            [hud removeFromSuperview];
            NSLog(@"网络繁忙!!!");
        }
        
    }];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 320;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 320)];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 270)];
    [image sd_setImageWithURL:[NSURL URLWithString:self.radioModel.wiki_cover[@"large"]]];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 270, SCREEN_WIDTH, 30)];
    title.text = self.radioModel.wiki_title;
    
    UILabel *title1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 300, SCREEN_WIDTH, 20)];
    title1.text = @"  曲目";
    [view addSubview:image];
    [view addSubview:title];
    [view addSubview:title1];
    
    return view;
    
    
    
    
}

- (UITableView *)tableView{
    
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.delegate = self;
        tableView.dataSource = self;
         UINib *nib = [UINib nibWithNibName:@"RadioDetailCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:kCellID];
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self setInViewWillAppear];
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    [self setInViewWillDisappear];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    
    self.tabBarController.tabBar.hidden = YES;
    
    
    
}


//给cell添加动画
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置Cell的动画效果为3D效果
    //设置x和y的初始值为0.1；
    cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    //x和y的最终值为1
    [UIView animateWithDuration:1 animations:^{
        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
}
- (void)RadioRightAction {
    [self presentViewController:[AudioPlayerController audioPlayerController] animated:YES completion:nil];
}

- (void)leftAction {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)dealloc {
    
    NSLog(@"页面销毁");
}
@end
