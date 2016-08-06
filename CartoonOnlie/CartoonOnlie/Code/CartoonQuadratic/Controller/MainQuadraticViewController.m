//
//  MainQuadraticViewController.m
//  CartoonOnlie
//
//  Created by lanou on 16/8/5.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "MainQuadraticViewController.h"
#import "QuadraticMainModel.h"
#import "QuadraticTwoCollectionViewCell.h"
#import "QuadrticFirstCollectionViewCell.h"
#import "SDCycleScrollView.h"
@interface MainQuadraticViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SDCycleScrollViewDelegate>

//数据源
@property (nonatomic,strong) NSMutableArray *quadraticArry;

//轮播图数据
@property (nonatomic,strong) NSMutableArray *SDCyclesArry;


@property (nonatomic,strong) UICollectionView *collectionView;



@end

@implementation MainQuadraticViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self SDCycleloadData];

    [self creatCollectionView];
    
    [self loadData];
}
#pragma mark 初始化设置
-(NSMutableArray *)quadraticArry
{
    if (_quadraticArry == nil) {
        _quadraticArry = [[NSMutableArray alloc]init];
    }
    return _quadraticArry;
}

-(NSMutableArray *)SDCyclesArry
{
    if (_SDCyclesArry ==nil) {
        _SDCyclesArry = [[NSMutableArray alloc]init];
    }
    return _SDCyclesArry;
}

#pragma mark 加载相关数据
//collection数据
-(void)loadData
{
   NSString *url = @"http://api.kuaikanmanhua.com/v1/topic_lists/mixed/new";
   
 
    [DownLoad dowmLoadWithUrl:url postBody:nil resultBlock:^(NSData *data) {
    
        if (data !=nil) {
           NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSArray *arr = dic[@"data"][@"infos"];
        
        for (NSDictionary *dic1 in arr) {
        
            NSArray *arr = dic1[@"topics"];
     
            for (NSDictionary *dic2 in arr) {
                
            QuadraticMainModel *model =
                [[QuadraticMainModel alloc]init];
            
            [model setValuesForKeysWithDictionary:dic2];
            
            [self.quadraticArry addObject:model];
            }
             NSLog(@"%ld",self.quadraticArry.count);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self creatSDCycleScrollView];
            [self.collectionView reloadData];
        });
        
        
    } else {
         NSLog(@"网络繁忙,请稍候再试");
    }
    }];
    
}

//轮播图数据
-(NSMutableArray *)SDCycleloadData
{
    NSString *url = @"http://api.kuaikanmanhua.com/v1/banners";
    
    [DownLoad dowmLoadWithUrl:url postBody:nil resultBlock:^(NSData *data) {
        
        if (data !=nil) {
            
             NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSMutableArray *arr = dic[@"data"][@"banner_group"];
        
        for (NSDictionary *dic1 in arr) {
            
             NSString *str = dic1[@"pic"];
            
            [self.SDCyclesArry addObject:str];
            
        }
            
        }else
        {
             NSLog(@"网络繁忙,请稍后在试");
        }

    }];
   
    return self.SDCyclesArry;
}




#pragma mark 创建相关视图
//创建collection
-(void)creatCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    //设置item
    layout.itemSize = CGSizeMake(90, 120);
    
    layout.minimumInteritemSpacing = 1;
    layout.minimumLineSpacing = 1;

    //设置分区边距
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 20, 5);
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,64, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    //注册 cell1
    [self.collectionView registerNib:[UINib nibWithNibName:@"QuadrticFirstCollectionViewCell" bundle:nil]forCellWithReuseIdentifier:@"cell1"];
    //注册 cell2
    [self.collectionView registerNib:[UINib nibWithNibName:@"QuadraticTwoCollectionViewCell" bundle:nil]forCellWithReuseIdentifier:@"cell2"];

   //注册分区头
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
    
    
//    //注册分区尾
//    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    
    
}

//创建轮播图
-(UIView *)creatSDCycleScrollView
{
    
    SDCycleScrollView *sdyc = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150) imageURLStringsGroup:self.SDCyclesArry];
        sdyc.delegate =self;
        return sdyc;
}

#pragma mark CollectinView代理方法实现
//返回分区个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return  self.quadraticArry.count;
}

//设置cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  
    
    QuadrticFirstCollectionViewCell* cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
    
    cell1.model = self.quadraticArry[indexPath.row];
    
    return cell1;
    
    
    
//    QuadraticTwoCollectionViewCell * cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell2" forIndexPath:indexPath];
//    
//    cell2.model = self.quadraticArry[indexPath.row];
//    
//    return cell2;
    
    
    
    
}

#pragma mark 返回collection高度相关设置
//返回分高度
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    //横向滚动 只有宽度有效
    //竖向滚动 只有高度有效
    return CGSizeMake(0, 180);
}

//设置分区头
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *sdcyc = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, SCREEN_WIDTH, 30)];
    label.text = @"人气飙升";
    label.backgroundColor  = [UIColor redColor];
    [sdcyc addSubview:label];
    [sdcyc addSubview:[self creatSDCycleScrollView]];
    
    
    
    return sdcyc;
}
@end
