//
//  RadioController.m
//  CartoonOnlie
//  电台主界面
//  Created by zhiling on 16/7/30.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "RadioController.h"
#import "RadioModel.h"
#import "RadioCell.h"
#import "AudioPlayerController.h"
#import "CartoonRadioDB.h"
#import "RadioDetailVC.h"


#import <SDCycleScrollView/SDCycleScrollView.h>

@interface RadioController () <UITableViewDelegate, UITableViewDataSource,SDCycleScrollViewDelegate>

//轮播图
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@property (nonatomic, strong) NSMutableArray  *hot_musicsArr;

@property (nonatomic, strong) NSMutableArray *hot_radiosArr;

@property (nonatomic, strong) NSMutableArray *musicsArr;

@property (nonatomic, strong) NSMutableArray *scrollerArr;

@property (nonatomic, strong) UIView *tagView;

@property (nonatomic, strong) UIButton *suspendBtn;

//数据
@property (nonatomic, strong) NSDictionary *dataDict;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation RadioController
- (void)RadioRightAction {
      [self presentViewController:[AudioPlayerController audioPlayerController] animated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"06"]style:UIBarButtonItemStyleDone target:self action:@selector(RadioRightAction)];
    
    self.navigationController.navigationBar.translucent = NO;
    
    [[CartoonRadioDB shareDataHandler] createTableWithName:@"hot_musics"];
    NSArray *arr = [[CartoonRadioDB shareDataHandler] allModelWithTableName:@"hot_musics"];
    if (arr.count == 0) {
        [self getScrollerViewData];
        [self getData];
    
    }else {
        
        self.hot_musicsArr = (NSMutableArray *)arr;
         [self.dataDict setValue:self.hot_musicsArr forKey:@"hot_musics"];
        
        
         [[CartoonRadioDB shareDataHandler] createTableWithName:@"hot_radios"];
        self.hot_radiosArr = (NSMutableArray *)[[CartoonRadioDB shareDataHandler] allModelWithTableName:@"hot_radios"];
         [self.dataDict setValue:self.hot_radiosArr forKey:@"hot_radios"];
   
         [[CartoonRadioDB shareDataHandler] createTableWithName:@"musics"];
        self.musicsArr = (NSMutableArray *)[[CartoonRadioDB shareDataHandler] allModelWithTableName:@"musics"];
        [self.dataDict setValue:self.musicsArr forKey:@"musics"];
        
        [[CartoonRadioDB shareDataHandler] createTableWithName:@"new_musics"];
        self.scrollerArr = (NSMutableArray *)[[CartoonRadioDB shareDataHandler] allModelWithTableName:@"new_musics"];
//        [self.dataDict setValue:self.musicsArr forKey:@"new_musics"];
      
        
    }
    
    
    
    
//    [self setNavbarBackgroundHidden:YES];
    [self createSuspendBtn];
    
    [self createTableView];
    if (self.scrollerArr.count != 0) {
        
             [self ScrollLocalImages];
        
    }

    
}

- (void)createTableView {
    
    self.tableView = [[UITableView alloc ]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 113) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:self.tableView];
    
    UINib *nib = [UINib nibWithNibName:@"RadioCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"radioCell"];
    
    
    
}

//获取tableView的数据
- (void)getData {
    
    [DownLoad dowmLoadWithUrl:@"http://moe.fm/explore?api=json&api_key=74915edacd1a54b1157833bb952f64a5055b78cdc&hot_musics=1&hot_radios=1&musics=1" postBody:nil resultBlock:^(NSData *data) {
        
        if (data != nil) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
//            NSLog(@"%@", dict);
            //做判断
            NSArray *hot_musics = dict[@"response"][@"hot_musics"];
            NSArray *hot_radios = dict[@"response"][@"hot_radios"];
            NSArray *musics = dict[@"response"][@"musics"];
            
            
            for (NSDictionary *hot_musicsDict in hot_musics) {
                
                RadioModel *model = [[RadioModel alloc] init];
                
                [model setValuesForKeysWithDictionary:hot_musicsDict];
                
                [[CartoonRadioDB shareDataHandler] createTableWithName:@"hot_musics"];
                [[CartoonRadioDB shareDataHandler] RadioModelModelWithTableName:@"hot_musics" model:model];
                
                [self.hot_musicsArr addObject:model];
            }
              [self.dataDict setValue:self.hot_musicsArr forKey:@"hot_musics"];
          
            
            for (NSDictionary *hot_radiosDict in hot_radios) {
                
                RadioModel *model = [[RadioModel alloc] init];
                
                [model setValuesForKeysWithDictionary:hot_radiosDict];
                
                [[CartoonRadioDB shareDataHandler] createTableWithName:@"hot_radios"];
                [[CartoonRadioDB shareDataHandler] RadioModelModelWithTableName:@"hot_radios" model:model];
                
                [self.hot_radiosArr addObject:model];
            }
            
              [self.dataDict setValue:self.hot_radiosArr forKey:@"hot_radios"];
            
            for (NSDictionary *musicsDict in musics) {
                
                RadioModel *model = [[RadioModel alloc] init];
                
                [model setValuesForKeysWithDictionary:musicsDict];
                
                [[CartoonRadioDB shareDataHandler] createTableWithName:@"musics"];
                [[CartoonRadioDB shareDataHandler] RadioModelModelWithTableName:@"musics" model:model];
                
                [self.musicsArr addObject:model];
            }
            
            [self.dataDict setValue:self.musicsArr forKey:@"musics"];
            
            
            NSLog(@"%lu", (unsigned long)self.dataDict.count);
            
      dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.tableView reloadData];
            });
            
            
        }else {
            
            NSLog(@"没有数据或者网络繁忙");
        }
       
    }];
    
}
//获取tableView的数据
- (void)getScrollerViewData {
    
    [DownLoad dowmLoadWithUrl:@"http://moe.fm/explore?api=json&api_key=74915edacd1a54b1157833bb952f64a5055b78cdc&new_musics=1" postBody:nil resultBlock:^(NSData *data) {
        
        if (data != nil) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               NSArray *new_musics = dict[@"response"][@"new_musics"];
            
            for (NSDictionary *dict in new_musics) {
                
                
                RadioModel *model = [RadioModel alloc];
                                   
                [model setValuesForKeysWithDictionary:dict];
                
                [[CartoonRadioDB shareDataHandler] createTableWithName:@"new_musics"];
                [[CartoonRadioDB shareDataHandler] RadioModelModelWithTableName:@"new_musics" model:model];
                
                [self.scrollerArr addObject:model];
                
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self ScrollLocalImages];
                
            });
            
            
        }else {
            
            NSLog(@"没有数据或者网络繁忙");
        }
        
    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 60;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RadioCell *cell = [tableView dequeueReusableCellWithIdentifier:@"radioCell"];
    
    
    cell.layer.cornerRadius = 8;
    cell.layer.masksToBounds = YES;
//    cell.backgroundColor = [UIColor lightGrayColor];
    
//    cell.backgroundColor = [UIColor magentaColor];
    if (indexPath.section == 0) {
        
     NSArray *arr = [self.dataDict objectForKey:@"hot_musics"];
        
        RadioModel *model = arr[indexPath.row];
        
        cell.radioModel = model;
        
        return cell;
        
        
    }else if (indexPath.section == 1) {
        
        NSArray *arr = [self.dataDict objectForKey:@"hot_radios"];
        
        RadioModel *model = arr[indexPath.row];
        
        cell.radioModel = model;
        
        return cell;
        
        
    }else {
        
        NSArray *arr = [self.dataDict objectForKey:@"musics"];
        
        RadioModel *model = arr[indexPath.row];
        
        cell.radioModel = model;
        
        return cell;
  
    }
    

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    
    return self.dataDict.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        NSArray *arr = [self.dataDict objectForKey:@"hot_musics"];
        return arr.count;
        
    }else if (section == 1) {
        
        NSArray *arr = [self.dataDict objectForKey:@"hot_radios"];
        return arr.count;
        
    }else {
        
        NSArray *arr = [self.dataDict objectForKey:@"musics"];
        return arr.count;
    }

}
- (UIView *)tagView{
    if (!_tagView) {
        _tagView = [[UIView alloc]initWithFrame:CGRectMake(10, 8, 5, 15)];
        _tagView.backgroundColor = UIColorFromRGB(0xffbf00);
        _tagView.layer.masksToBounds = YES;
        _tagView.layer.cornerRadius = 2.5;
    }
    return _tagView;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view;
    
    UILabel *label;
    
    if (section == 0) {
        view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        label = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, 150, 30)];
        label.textColor = [UIColor lightGrayColor];
        label.text = @"hot_musics";
        [view addSubview:self.tagView];
        [view addSubview:label];
        
        return view;
    }else if (section == 1) {
        
        
        view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        label = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, 150, 30)];
        label.textColor = [UIColor lightGrayColor];
        label.text = @"hot_radios";
        [view addSubview:self.tagView];
        [view addSubview:label];
        
        return view;
        
    }else {
        
        view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        label = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, 150, 30)];
        label.textColor = [UIColor lightGrayColor];
        label.text = @"musics";
        [view addSubview:self.tagView];
        [view addSubview:label];
        
        return view;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 30;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RadioDetailVC *detailVC = [[RadioDetailVC alloc] init];
    
    if (indexPath.section == 0) {
        
        
          NSArray *arr = [self.dataDict objectForKey:@"hot_musics"];
          RadioModel *model = arr[indexPath.row];
        
        detailVC.radioModel = model;
        [self.navigationController pushViewController:detailVC animated:YES];
    }else if (indexPath.section == 1) {
        
        NSArray *arr = [self.dataDict objectForKey:@"hot_radios"];
        RadioModel *model = arr[indexPath.row];
        
        detailVC.radioModel = model;
        [self.navigationController pushViewController:detailVC animated:YES];
    }else {
        NSArray *arr = [self.dataDict objectForKey:@"musics"];
        RadioModel *model = arr[indexPath.row];
        
        detailVC.radioModel = model;
        [self.navigationController pushViewController:detailVC animated:YES]; 
    }
    

    
    
    
    
    
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



#pragma mark -- 创建悬浮按钮
- (void)createSuspendBtn
{
    self.suspendBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.suspendBtn.frame = CGRectMake(SCREEN_WIDTH - 40, SCREEN_HEIGHT - 160, 40, 40);
    
    self.suspendBtn.layer.cornerRadius = 20;
    
    self.suspendBtn.layer.borderWidth = 0.2;
    self.suspendBtn.backgroundColor = [UIColor clearColor];
    [self.suspendBtn setTitle:@"置顶" forState:UIControlStateNormal];
    self.suspendBtn.layer.masksToBounds = YES;
    
    [self.suspendBtn addTarget:self action:@selector(toTop) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.suspendBtn];
}

#pragma mark -- 滚动视图会调用的方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
//    NSLog(@"scrollView.contentOffset.y == %f", scrollView.contentOffset.y);
//    if (scrollView.contentOffset.y<64) {
//        [self setNavbarBackgroundHidden:YES];
//    }else
//    {
//        [self setNavbarBackgroundHidden:NO];
//    }
//    
    
    if (scrollView == self.tableView) {
        if (self.tableView.contentOffset.y >= SCREEN_HEIGHT / 3) {
            self.suspendBtn.hidden = NO;
            
            [self.view bringSubviewToFront:self.suspendBtn];
        } else if (self.tableView.contentOffset.y < SCREEN_HEIGHT / 3) {
            
            [UIView animateWithDuration:1 animations:^{
                
                
                
                self.suspendBtn.hidden = YES;
            }];
        }
    }
}


#pragma mark -- 按钮置顶方法
- (void)toTop
{
    // 快速停止正在滚动的视图
    CGPoint offset = CGPointMake(0, 0);
    (self.tableView.contentOffset.y > 0) ? offset.y-- : offset.y++;
    [self.tableView setContentOffset:offset animated:NO];
    
}



#pragma mark 创建轮播图
- (void)ScrollLocalImages
{
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, 260);
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:rect delegate:self placeholderImage:[UIImage imageNamed:@"PlacehoderImage.png"]];
    NSMutableArray *urlStr = [[NSMutableArray alloc] init];
    
    for (RadioModel *model in self.scrollerArr) {
        
       NSString *str = model.wiki_cover[@"large"];
        
        [urlStr addObject:str];
    }
    NSMutableArray *titleStr = [[NSMutableArray alloc] init];
    for (RadioModel *model in self.scrollerArr) {
        
        NSString *str = model.wiki_title;
        
        [titleStr addObject:str];
    }
    // 网络图片数组
    self.cycleScrollView.imageURLStringsGroup = urlStr;
    // 设置图片显示类型
    self.cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
    self.cycleScrollView.showPageControl = YES;
    self.cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    self.cycleScrollView.pageDotImage = [UIImage imageNamed:@"pageCon.png"];
    self.cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"pageConSel.png"];
    self.cycleScrollView.titlesGroup = titleStr;
    //    [self.view addSubview:self.cycleScrollView];
    self.tableView.tableHeaderView = self.cycleScrollView;
}

#pragma mark 点击图片回调
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
//    NSLog(@"%ld",(long)index);
}

#pragma mark 滚动回调
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
//    NSLog(@"%ld",(long)index);
}

- (NSDictionary *)dataDict {
    
    if (_dataDict == nil) {
        
        _dataDict = [[NSMutableDictionary alloc] init];
        
    }
    return _dataDict;
}
- (NSMutableArray *)hot_musicsArr {
    if (_hot_musicsArr == nil) {
        
        _hot_musicsArr = [NSMutableArray array];
    }
    
    return _hot_musicsArr;
}

- (NSMutableArray *)hot_radiosArr {
    if (_hot_radiosArr == nil) {
        
        _hot_radiosArr = [NSMutableArray array];
    }
    
    return _hot_radiosArr;
}


- (NSMutableArray *)musicsArr {
    if (_musicsArr == nil) {
        
        _musicsArr = [NSMutableArray array];
    }
    
    return _musicsArr;
}
- (NSMutableArray *)scrollerArr {
    if (_scrollerArr == nil) {
        
        _scrollerArr = [NSMutableArray array];
    }
    
    return _scrollerArr;
}
//- (NSMutableArray *)scrollerTitleArr {
//    if (_scrollerTitleArr == nil) {
//        
//        _scrollerTitleArr = [NSMutableArray array];
//    }
//    
//    return _scrollerTitleArr;
//}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
//    [self.navigationController setNavigationBarHidden:YES];
     self.tabBarController.tabBar.hidden = NO;
    
//    self.navigationController.navigationBar.barTintColor = KBarOrNarColor;
    
         [[JFJumpToControllerManager shared].navigation setNavigationBarHidden:YES];
    
    
}
- (void)dealloc {
    
    NSLog(@"页面销毁");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
