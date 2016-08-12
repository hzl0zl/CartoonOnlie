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


@interface FunnyDetailViewController ()<UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout>


@property (nonatomic, strong) UICollectionView *collectionView;

@property (strong, nonatomic) IBOutlet UIImageView *titleImage;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UIView *topView;


@property (strong, nonatomic) IBOutlet UIView *bottomView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (strong, nonatomic) IBOutlet UILabel *authorL;

@property (strong, nonatomic) IBOutlet UILabel *circulateL;

@property (strong, nonatomic) IBOutlet UILabel *statusL;
@property (strong, nonatomic) IBOutlet UILabel *popularL;
@property (strong, nonatomic) IBOutlet UILabel *descL;

@property (strong, nonatomic) IBOutlet UIButton *showDescBtn;

@property (strong, nonatomic) IBOutlet UIButton *collectionBtn;

@end


@implementation FunnyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    
    self.tabBarController.tabBar.hidden= YES;
    
    self.tabBarController.tabBar.translucent = YES;
    
    [self.view addSubview:self.bottomView];
    
    [self setTopView];
    
    [self setTopViewBackground];
    
    [self setMiddleView];
    
//    [self createDataArray];
    
    [self.view addSubview:self.collectionView];
    
    [self getData];
    
    
    
}

- (void)getData
{
    NSString *str = [NSString stringWithFormat:@"albumId=%@&customerId=2208260", self.albumId];
    
    [DownLoad dowmLoadWithUrl:FUNNY postBody:str resultBlock:^(NSData *data) {
        
        if (data != nil) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray *array = dic[@"data"][@"list"];
            
            for (NSDictionary *dict in array) {
                
                FunnyDetailModel *model = [[FunnyDetailModel alloc] init];
                
                [model setValuesForKeysWithDictionary:dict];
                
                [self.dataArray addObject:model];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.collectionView reloadData];
            });
        }
  
    }];
}


#pragma mark -- 顶部视图背景
- (void)setTopViewBackground
{
    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
 
    topImageView.alpha = 1;
    
//    [topImageView sd_setImageWithURL:[NSURL URLWithString:self.model.coverPic]];
    
    topImageView.image = [UIImage imageNamed:@"background"];
    
    [self.topView addSubview:topImageView];
}

#pragma mark -- 中间视图
- (void)setMiddleView
{
    
//    FunnyDetailModel *model = self.dataArray;
    
    self.authorL.text = [NSString stringWithFormat:@"作者: %@", self.model.author];
    
    self.circulateL.text = [NSString stringWithFormat:@"发行商: %@", self.model.authorName];
    if (self.model.status) {
         self.statusL.text = @"状态: 连载中";
    }else
    {
        self.statusL.text = @"状态: 已完结";
    }
    self.popularL.text = [NSString stringWithFormat:@"人气: %@", self.model.popular];
    
    self.descL.text = [NSString stringWithFormat:@"简介: %@", self.model.descriptions];
    
    self.showDescBtn.layer.cornerRadius = 10.0;
    self.showDescBtn.layer.masksToBounds = YES;
   
}

- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        // 每一个item的大小
        flowLayout.itemSize = CGSizeMake(70, 40);
        
        // 设置最小列间距-- 默认值为10
        // 列数是根据Item的大小和最小间距来自动调整
        flowLayout.minimumInteritemSpacing = 5;
        
        // 最小行间距--默认值为10
        flowLayout.minimumLineSpacing = 10;
        
        // 设置滚动方向
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        // 设置距离分区的边距
        flowLayout.sectionInset = UIEdgeInsetsMake(8, 2, 0, 2);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 320, SCREEN_WIDTH, SCREEN_HEIGHT - 369) collectionViewLayout:flowLayout];
        
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
}

#pragma mark -- 设置头部视图大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size= CGSizeMake(0, 40);
    return size;
}

#pragma mark -- 尾部视图大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    CGSize size= CGSizeMake(0, 50);
    return size;
}

#pragma mark -- 头部视图注册
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    // collectionView当中分区头和分区尾, 也使用了重用池技术
    // 判断是否是分区头
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        
        UILabel *headerL = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 120, 20)];
        
        headerL.text = @"目录";
        
        [reusableView addSubview:headerL];
        reusableView.backgroundColor = [UIColor colorWithRed:226.0/255 green:226.0/255 blue:237.0/255 alpha:1.0];
        return reusableView;
    }else
    {
        UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        reusableView.backgroundColor = [UIColor redColor];
        UIView *bottomV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        bottomV.backgroundColor = [UIColor cyanColor];
        
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
    
    cell.volumecountL.layer.cornerRadius = 18;
    cell.volumecountL.layer.borderWidth = 0.1;
    
    return cell;
}

#pragma mark -- 视图即将出现
- (void)viewWillAppear:(BOOL)animated
{
    
//    self.btn = [[UIBarButtonItem alloc] initWithTitle:@"收藏" style:UIBarButtonItemStylePlain target:self action:@selector(collectionAction:)];
//    self.navigationItem.rightBarButtonItem = self.btn;
    
    self.collectionBtn.hidden = NO;
    
    NSArray *array = [[DataHandler shareDataHandler] allCartoon];
    if(array == nil)
    {
        [self.collectionBtn setTitle:@"收藏" forState:UIControlStateNormal];
    }
    else
    {
        for (FunListModel *model in array) {
            if ([self.model.name isEqualToString:model.name]) {
                [self.collectionBtn setTitle:@"已收藏" forState:UIControlStateNormal];
            }
        }
    }
    
}


#pragma mark -- 返回按钮点击方法
- (IBAction)backAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark -- 显示简介详情
- (IBAction)showDescAction:(id)sender {
    
    
    
}


#pragma mark -- 推出收藏页面
- (IBAction)showCollectionView:(id)sender {
    
    CollectionController *collectionVc = [[CollectionController alloc] initWithNibName:@"CollectionController" bundle:nil];
    
    collectionVc.model = self.model;
    
    [self.navigationController pushViewController:collectionVc animated:YES];
    
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
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark -- 下载按钮点击方法
- (IBAction)downLoadAction:(id)sender {
}

#pragma mark -- 分享按钮点击方法
- (IBAction)shareAction:(id)sender {
}

#pragma mark -- 视图即将消失
- (void)viewWillDisappear:(BOOL)animated
{
    [self.bottomView removeFromSuperview];
    
    self.navigationController.navigationBar.hidden = NO;
    
    self.tabBarController.tabBar.hidden= NO;
    
    self.tabBarController.tabBar.translucent = NO;
}


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
