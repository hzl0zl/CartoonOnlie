//
//  FunnyDetailViewController.m
//  CartoonOnlie
//
//  Created by lanou on 16/8/1.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "FunnyDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "VolumecountCell.h"


@interface FunnyDetailViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>


@property (nonatomic, strong) UICollectionView *collectionView;

@property (strong, nonatomic) IBOutlet UIImageView *titleImage;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UIView *bottomView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation FunnyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSLog(@"%@", self.model);
    
    [self setTopView];
    
    [self createDataArray];
    
    [self.view addSubview:self.collectionView];
    
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
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 300, SCREEN_WIDTH, SCREEN_HEIGHT - 349) collectionViewLayout:flowLayout];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        
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

- (void)createDataArray
{
     int count = [self.model.updateSize intValue];
    
    for (int i = 0; i < count; i++) {
        NSString *nameStr = [NSString stringWithFormat:@"第 %d 话", i];
        [self.dataArray addObject:nameStr];
    }
    NSLog(@"%ld", self.dataArray.count);
}

// 设置头部视图
- (void)setTopView
{
    [self.titleImage sd_setImageWithURL:[NSURL URLWithString:self.model.coverPic]];
    self.titleImage.layer.cornerRadius = 45;
    // 将圆以外的东西去掉
    self.titleImage.layer.masksToBounds = YES;
    
    self.titleLabel.text = self.model.name;
}

#pragma mark -- 设置头部视图大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size= CGSizeMake(0, 40);
    return size;
}



#pragma mark -- 头部视图注册
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    // collectionView当中分区头和分区尾, 也使用了重用池技术
    // 判断是否是分区头
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        reusableView.backgroundColor = [UIColor greenColor];
        return reusableView;
    }else
    {
        UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        reusableView.backgroundColor = [UIColor redColor];
        
        return reusableView;
    }
    return nil;
}


#pragma mark -- 返回每个分区的cell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    VolumecountCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"volumecountcell" forIndexPath:indexPath];
    
    [cell.volumecountBtn setTitle:self.dataArray[indexPath.item] forState:UIControlStateNormal];
    
    cell.volumecountBtn.layer.cornerRadius = 18;
    cell.volumecountBtn.layer.borderWidth = 0.1;
    
    return cell;
}

// 视图即将出现
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


- (void)viewWillDisappear:(BOOL)animated
{
    [self.bottomView removeFromSuperview];
    
    self.navigationController.navigationBar.hidden = NO;
    
    self.tabBarController.tabBar.hidden= NO;
    
    self.tabBarController.tabBar.translucent = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
