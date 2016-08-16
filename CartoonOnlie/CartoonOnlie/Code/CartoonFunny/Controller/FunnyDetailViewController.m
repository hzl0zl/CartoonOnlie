//
//  FunnyDetailViewController.m
//  CartoonOnlie
//
//  Created by lanou on 16/8/1.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "FunnyDetailViewController.h"
#import "VolumecountCell.h"
#import <CoreImage/CoreImage.h>
#import "ReadViewController.h"
#import "DataHandler.h"
#import "CollectionController.h"
#import "MBProgressHUD.h"


@interface FunnyDetailViewController ()<UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout>


@property (nonatomic, strong) UICollectionView *collectionView;

@property (strong, nonatomic) IBOutlet UIImageView *titleImage;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UIView *topView;

@property (strong, nonatomic) IBOutlet UIView *bottomView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (strong, nonatomic) IBOutlet UILabel *authorL;

@property (strong, nonatomic) IBOutlet UILabel *updateTimeL;

@property (strong, nonatomic) IBOutlet UILabel *statusL;
@property (strong, nonatomic) IBOutlet UILabel *popularL;
@property (strong, nonatomic) IBOutlet UILabel *descL;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *descHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *middleHeight;

@property (strong, nonatomic) IBOutlet UIButton *collectionBtn;

@property (strong, nonatomic) IBOutlet UIView *middleView;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIButton *coverBtn;

@property (nonatomic, assign) CGSize size;

@property (strong, nonatomic) IBOutlet UIImageView *topImageView;


@end

BOOL isFavor;

@implementation FunnyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTopViewBackground];
    
    [self setTopView];
    
    
    
    [self setMiddleView];
    
    
    [self.view addSubview:self.collectionView];
    
    [self getData];
    
    
}

#pragma mark -- 获取网络数据
- (void)getData
{

    MBProgressHUD *hud = [[MBProgressHUD alloc] init];
    [self.view addSubview:hud];
    hud.labelText = @"努力加载中";
    NSString *string = [NSString stringWithFormat:@"http://api.youqudao.com/mhapi/api/album/detail?albumId=%@&customerId=2208260", self.model.albumId];
    
    [DownLoad dowmLoadWithUrl:string postBody:nil resultBlock:^(NSData *data) {
        
        if (data != nil) {
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray *array = dic[@"data"][@"list"];
            
            for (NSDictionary *dict in array) {
                
                FunnyDetailModel *model = [[FunnyDetailModel alloc] init];
                
                [model setValuesForKeysWithDictionary:dict];
                
                [self.dataArray addObject:model];
            }
            
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [hud removeFromSuperview];
                self.imageView.image = [UIImage imageNamed:@"bottomView"];
                
                [self.collectionView reloadData];
            });
        }
  
    }];
}


#pragma mark -- 顶部视图背景
- (void)setTopViewBackground
{
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blur];
    
    effectView.alpha = 0.8;
    
    effectView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 150);
    
    [self.topImageView addSubview:effectView];
    
    [self.topImageView sd_setImageWithURL:[NSURL URLWithString:self.model.coverPic]];

}

#pragma mark -- 中间视图
- (void)setMiddleView
{
    self.authorL.text = [NSString stringWithFormat:@"作者: %@", self.model.author];
    
    self.updateTimeL.text = [NSString stringWithFormat:@"更新: %@", [self updateTime:self.model.updateTime]];

    if (self.model.status) {
         self.statusL.text = @"状态: 连载中";
    }else
    {
        self.statusL.text = @"状态: 已完结";
    }
    self.popularL.text = [NSString stringWithFormat:@"人气: %@", self.model.popular];
    
    NSString *descStr = [NSString stringWithFormat:@"简介: %@", self.model.descriptions];
    self.descL.text = descStr;
    
    
   
}

#pragma mark -- 显示详情按钮方法
- (void)selectAction:(id)sender
{
    static BOOL isSelect = YES;
    
    if (isSelect) {
        self.descHeight.constant = (int)(self.descL.text.length * 15.0/ (SCREEN_WIDTH - 20) + 1) * 15;
        self.middleView.frame = CGRectMake(0, 160, SCREEN_WIDTH, 110 + self.descHeight.constant);
        self.collectionView.frame = CGRectMake(0, 280 + self.descHeight.constant - 40, SCREEN_WIDTH, SCREEN_HEIGHT - 329 - (self.descHeight.constant - 40));
        [self.coverBtn setBackgroundImage:[UIImage imageNamed:@"up"] forState:UIControlStateNormal];
        
    }else
    {
        self.descHeight.constant = 40;
        self.middleView.frame = CGRectMake(0, 160, SCREEN_WIDTH, 150);
        self.collectionView.frame = CGRectMake(0, 280, SCREEN_WIDTH, SCREEN_HEIGHT - 329);
        [self.coverBtn setBackgroundImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
    }
    isSelect = !isSelect;
    
    
    self.coverBtn.selected = !self.coverBtn.selected;
}
    

#pragma mark -- 将时间戳转换成标准时间
- (NSString *)updateTime:(NSNumber *)state
{
    NSString *string = [NSString stringWithFormat:@"%@", state];
    
    NSTimeInterval time = [string doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    NSString *currentDateStr = [dateFormat stringFromDate:date];
    
    
    return currentDateStr;
}

- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        // 每一个item的大小
        flowLayout.itemSize = CGSizeMake(70, 40);
        
        // 列数是根据Item的大小和最小间距来自动调整
        flowLayout.minimumInteritemSpacing = 5;
        
        // 设置距离分区的边距
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 2, 0, 2);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 280, SCREEN_WIDTH, SCREEN_HEIGHT - 329) collectionViewLayout:flowLayout];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        _collectionView.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:244.0/255 alpha:1.0];

        UINib *nib = [UINib nibWithNibName:@"VolumecountCell" bundle:nil];
        
        [_collectionView registerNib:nib forCellWithReuseIdentifier:@"volumecountcell"];
    
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];
        
    }
    return _collectionView;
}


- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


#pragma mark -- 设置顶部视图
- (void)setTopView
{
    [self.titleImage sd_setImageWithURL:[NSURL URLWithString:self.model.coverPic]];
    self.titleImage.layer.cornerRadius = 45;
    // 将圆以外的东西去掉
    self.titleImage.layer.masksToBounds = YES;
    
    self.titleLabel.text = self.model.name;
    
//    self.titleLabel.textColor = [UIColor brownColor];
//    
//    [self.collectionBtn setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
}

#pragma mark -- 设置头部视图大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size= CGSizeMake(0, 60);
    return size;
}

#pragma mark -- 尾部视图大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (self.dataArray.count < 15) {
        self.size = CGSizeMake(0, 80);
    }
    self.size= CGSizeMake(0, 50);
    return self.size;
}

#pragma mark -- 头部视图注册
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    // collectionView当中分区头和分区尾, 也使用了重用池技术
    // 判断是否是分区头
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        
        UILabel *headerL = [[UILabel alloc] initWithFrame:CGRectMake(5, 30, 120, 20)];
        self.coverBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        self.coverBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH, 20);
        
        [self.coverBtn setBackgroundImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];

        [self.coverBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        [reusableView addSubview:self.coverBtn];
        
        headerL.text = @"目录";
        
        [reusableView addSubview:headerL];
        reusableView.backgroundColor = [UIColor colorWithRed:226.0/255 green:226.0/255 blue:237.0/255 alpha:1.0];
        return reusableView;
    }else
    {
        UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        UIView *bottomV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        if (self.dataArray.count < 15) {
            self.imageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 80);
        }
        
        [bottomV addSubview:self.imageView];
        
        [reusableView addSubview:bottomV];
        
        return reusableView;
    }
    return nil;
}


#pragma mark -- 返回每个分区的cell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

#pragma mark -- 显示cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    VolumecountCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"volumecountcell" forIndexPath:indexPath];
    
    FunnyDetailModel *model = self.dataArray[indexPath.item];
    
    cell.model = model;
    return cell;
}

#pragma mark -- 视图即将出现
- (void)viewWillAppear:(BOOL)animated
{
    self.bottomView.hidden = NO;
    
    self.navigationController.navigationBar.hidden = YES;
    
    self.tabBarController.tabBar.hidden= YES;
    
    self.tabBarController.tabBar.translucent = YES;
    
    self.collectionBtn.hidden = NO;
    
    NSArray *array = [[DataHandler shareDataHandler] allCartoon];
    if(array.count)
    {
        for (FunListModel *model in array) {
            if (![self.model.name isEqualToString:model.name]) {
                [self.collectionBtn setTitle:@"收藏" forState:UIControlStateNormal];
            }else
            {
                [self.collectionBtn setTitle:@"已收藏" forState:UIControlStateNormal];
            }
        }
    }
    else
    {
        [self.collectionBtn setTitle:@"收藏" forState:UIControlStateNormal];
    }
    
}


#pragma mark -- 返回按钮点击方法
- (IBAction)backAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



#pragma mark -- 推出收藏页面
- (IBAction)showCollectionView:(id)sender {
    
    CollectionController *collectionVc = [[CollectionController alloc] initWithNibName:@"CollectionController" bundle:nil];
    
    collectionVc.model = self.model;
    
    [self.navigationController pushViewController:collectionVc animated:NO];
    
    self.bottomView.hidden = YES;
    
}


#pragma mark -- 收藏按钮点击方法
- (IBAction)collectionAction:(id)sender {
    
    // 查询数据库
    NSArray *array = [[DataHandler shareDataHandler] allCartoon];
    
    // 遍历数组
    for (FunListModel *model in array) {
        if ([self.model.name isEqualToString:model.name]) {
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"收藏已存在" message:nil preferredStyle:UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil]];
            
            [self presentViewController:alert animated:YES completion:nil];
            
            // 跳出整个方法
            return;
            
        }
    }
    
    
    [[DataHandler shareDataHandler] collectionCartoon:self.model];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"收藏成功" message:nil preferredStyle:UIAlertControllerStyleAlert];

    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        [self.collectionBtn setTitle:@"已收藏" forState:UIControlStateNormal];
        
        
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark -- 视图即将消失
- (void)viewWillDisappear:(BOOL)animated
{
    self.bottomView.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
    
    self.tabBarController.tabBar.hidden= NO;
    
    self.tabBarController.tabBar.translucent = NO;
}


#pragma mark -- 点击cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ReadViewController *readVc = [[ReadViewController alloc] initWithNibName:@"ReadViewController" bundle:nil];
    
    readVc.model = self.dataArray[indexPath.item];
    
    [self.navigationController pushViewController:readVc animated:YES];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
