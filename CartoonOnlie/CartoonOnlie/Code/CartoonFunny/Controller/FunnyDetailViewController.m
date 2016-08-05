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

@end

@implementation FunnyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTopView];
    
//    [self setTopViewBackground];
    
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
 
    topImageView.alpha = 0.5;

//    CIContext *context = [CIContext contextWithOptions:nil];
//    CIImage *image = [CIImage imageWithContentsOfURL:[NSURL URLWithString:self.model.coverPic]];;
//    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
//    [filter setValue:image forKey:kCIInputImageKey];
//    [filter setValue:@2.0f forKey: @"inputRadius"];
//    CIImage *result = [filter valueForKey:kCIOutputImageKey];
//    CGImageRef outImage = [context createCGImage: result fromRect:[result extent]];
//    topImageView.image = [UIImage imageWithCGImage:outImage];

    
    [self.topView addSubview:topImageView];
}

#pragma mark -- 中间视图
- (void)setMiddleView
{
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
    
    
    self.navigationController.navigationBar.hidden = YES;
    
    self.tabBarController.tabBar.hidden= YES;
    
    self.tabBarController.tabBar.translucent = YES;
}


#pragma mark -- 返回按钮点击方法
- (IBAction)backAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- 收藏按钮点击方法
- (IBAction)collectionAction:(id)sender {
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
