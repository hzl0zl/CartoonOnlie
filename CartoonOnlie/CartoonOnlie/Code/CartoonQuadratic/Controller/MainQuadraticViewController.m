//
//  MainQuadraticViewController.m
//  CartoonOnlie
//
//  Created by lanou on 16/8/5.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "MainQuadraticViewController.h"
#import "QuadraticMainModel.h"
#import "QuadrticFirstCollectionViewCell.h"
#import "SDCycleScrollView.h"
#import "SectionOneCell.h"
#import "QuadrticCellController.h"

@interface MainQuadraticViewController ()

////数据源
//@property (nonatomic,strong) NSMutableArray *quadraticArry;
//
//@property (nonatomic,strong) NSMutableArray *quadraticArry2;
//
//@property (nonatomic,strong) NSMutableArray *quadraticArry3;
////轮播图数据
//@property (nonatomic,strong) NSMutableArray *SDCyclesArry;
//
//@property (nonatomic,strong) UICollectionView *collectionView;
//
//@property (nonatomic, strong) UICollectionViewFlowLayout *layout;




@end

@implementation MainQuadraticViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//     [self loadData];
//    [self SDCycleloadData];
//    [self creatCollectionView];
   
//    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSLog(@"%@", path);
  
}

//#pragma mark 加载相关数据
////collection数据
//-(void)loadData
//{
//   NSString *url = @"http://api.kuaikanmanhua.com/v1/topic_lists/mixed/new";
//   
// 
//    [DownLoad dowmLoadWithUrl:url postBody:nil resultBlock:^(NSData *data) {
//    
//        if (data !=nil) {
//           NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        
//        NSArray *arr = dic[@"data"][@"infos"];
//        
//          NSArray *renqiArray = arr[0][@"topics"];
//            
//        for (NSDictionary *dic1 in renqiArray) {
//         
//                QuadraticMainModel *model = [[QuadraticMainModel alloc] init];
//                
//                [model setValuesForKeysWithDictionary:dic1];
//                
//                [self.quadraticArry addObject:model];
//     
//        }
//        
//            
//            NSArray *paihangArray = arr[1][@"topics"];
//            
//            for (NSDictionary *dic1 in paihangArray) {
//                
//                QuadraticMainModel *model = [[QuadraticMainModel alloc] init];
//                
//                [model setValuesForKeysWithDictionary:dic1];
//                
//                [self.quadraticArry2 addObject:model];
//                
//            } 
//            
//                 [self.quadraticArry removeObjectAtIndex:3];
//        dispatch_async(dispatch_get_main_queue(), ^{
////            [self creatSDCycleScrollView];
//            [self.collectionView reloadData];
//        });
//        
//        
//    } else {
//         NSLog(@"网络繁忙,请稍候再试");
//    }
//    }];
//    
//}
//
////轮播图数据
//- (void)SDCycleloadData
//{
//    NSString *url = @"http://api.kuaikanmanhua.com/v1/banners";
//    
//    [DownLoad dowmLoadWithUrl:url postBody:nil resultBlock:^(NSData *data) {
//        
//        if (data !=nil) {
//            
//             NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        
//        NSMutableArray *arr = dic[@"data"][@"banner_group"];
//        
//        for (NSDictionary *dic1 in arr) {
//            
//             NSString *str = dic1[@"pic"];
//            NSString *valueStr = dic1[@"value"];
//            [self.SDCyclesArry addObject:str];
//            [self.quadraticArry3 addObject:valueStr];
//            
//        }
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//
//                [self.collectionView reloadData];
//            });
//            
//            
//        }else
//        {
//             NSLog(@"网络繁忙,请稍后在试");
//        }
//
//    }];
//   
// 
//}
//
//
//
//
//#pragma mark 创建相关视图
////创建collection
//-(void)creatCollectionView
//{
//    self.layout = [[UICollectionViewFlowLayout alloc]init];
//    
//    //设置item
//    self.layout.itemSize = CGSizeMake(115, 150);
//    
////    self.layout.minimumInteritemSpacing = 2;
////    self.layout.minimumLineSpacing = 2;
//
//    //设置分区边距
//    self.layout.sectionInset = UIEdgeInsetsMake(5, 5, 2, 2);
//    
//    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,64, SCREEN_WIDTH, SCREEN_HEIGHT - 113) collectionViewLayout:self.layout];
//    
//    self.collectionView.delegate = self;
//    self.collectionView.dataSource = self;
//    [self.view addSubview:self.collectionView];
//    
//    self.collectionView.backgroundColor = [UIColor grayColor];
//    //注册 cell1
//    [self.collectionView registerNib:[UINib nibWithNibName:@"QuadrticFirstCollectionViewCell" bundle:nil]forCellWithReuseIdentifier:@"firstCell"];
//    //注册 cell2
//    [self.collectionView registerNib:[UINib nibWithNibName:@"SectionOneCell" bundle:nil]forCellWithReuseIdentifier:@"sectionCell"];
//
//   //注册分区头
//    
//    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
//    
//    
//    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header1"];
//    
//}
//
////创建轮播图
//-(UIView *)creatSDCycleScrollView
//{
//    
//    SDCycleScrollView *sdyc = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180) imageURLStringsGroup:self.SDCyclesArry];
//    sdyc.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
//    sdyc.pageDotImage = [UIImage imageNamed:@"pageCon.png"];
//    sdyc.currentPageDotImage = [UIImage imageNamed:@"pageConSel.png"];
//        sdyc.delegate =self;
//        return sdyc;
//}
//
//#pragma mark CollectinView代理方法实现
////返回分区个数
//-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    if (section == 0) {
//        return self.quadraticArry.count;
//        
//    }else{
//        
//        return self.quadraticArry2.count;
//    }
//}
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    
//    return 2;
//}
////设置cell
//-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//   
//    
//    if (indexPath.section == 0) {
//        SectionOneCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"sectionCell" forIndexPath:indexPath];
//        cell.model = self.quadraticArry[indexPath.row];
//        return cell;
//        
//    }else {
//     
//        QuadrticFirstCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"firstCell" forIndexPath:indexPath];
//        cell.model = self.quadraticArry2[indexPath.row];
//        cell.numberL.text = [NSString stringWithFormat:@"NO.%ld", indexPath.row + 1];
//        return cell;
//    }
//        
//    
//    
//
//
//}
//
//#pragma mark 返回collection高度相关设置
////返回分高度
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    //横向滚动 只有宽度有效
//    //竖向滚动 只有高度有效
//    if (section == 0) {
//          return CGSizeMake(0, 210);
//    }else {
//        return CGSizeMake(0, 30);
//    }
//    
//  
//}
//
////设置分区头
//-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//       if (indexPath.section == 0) {
//           UICollectionReusableView *sdcyc = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];
//           //    QuadraticMainModel *model;
//           UILabel *label;
//
//        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 180, SCREEN_WIDTH, 30)];
//        label.text = @"人气飙升";
//        label.backgroundColor  = [UIColor whiteColor];
//        label.font = [UIFont systemFontOfSize:13];
//        [sdcyc addSubview:label];
//        [sdcyc addSubview:[self creatSDCycleScrollView]];
//        
//        return sdcyc;
//        
//    }else {
//        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header1" forIndexPath:indexPath];
//        //    QuadraticMainModel *model;
//        UILabel *label;
//
//        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
//        label.text = @"每周排行榜";
//        label.backgroundColor  = [UIColor whiteColor];
//        label.font = [UIFont systemFontOfSize:13];
//        [view addSubview:label];
//        return view;
//    }
//    
// 
//
//   
//}
//
////点击方法
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    QuadrticCellController *cellVC = [[QuadrticCellController alloc]init];
//    
//    QuadraticMainModel *model;
//   
//    if (indexPath.section == 0) {
//        
//        model = self.quadraticArry[indexPath.row];
//        cellVC.urlID =model.ids;
//    }else {
//
//        model = self.quadraticArry2[indexPath.row];
//        cellVC.urlID =model.ids;
//
//    }
//    
//    [self.navigationController pushViewController:cellVC animated:YES];
//    
//    
//}
//
//- (void)viewWillAppear:(BOOL)animated {
//    
//    [super viewWillAppear:animated];
//    
//    self.collectionView.frame =CGRectMake(0,64, SCREEN_WIDTH, SCREEN_HEIGHT - 113);
//}
//
//
//#pragma mark 初始化设置
//-(NSMutableArray *)quadraticArry
//{
//    if (_quadraticArry == nil) {
//        _quadraticArry = [[NSMutableArray alloc]init];
//    }
//    return _quadraticArry;
//}
//-(NSMutableArray *)quadraticArry2
//{
//    if (_quadraticArry2 == nil) {
//        _quadraticArry2 = [[NSMutableArray alloc]init];
//    }
//    return _quadraticArry2;
//}
//
//-(NSMutableArray *)quadraticArry3
//{
//    if (_quadraticArry3 == nil) {
//        _quadraticArry3 = [[NSMutableArray alloc]init];
//    }
//    return _quadraticArry3;
//}
//
//
//-(NSMutableArray *)SDCyclesArry
//{
//    if (_SDCyclesArry ==nil) {
//        _SDCyclesArry = [[NSMutableArray alloc]init];
//    }
//    return _SDCyclesArry;
//}

@end
