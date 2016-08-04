//
//  TerrofyingController.m
//  CartoonOnlie
//
//  Created by zhiling on 16/7/30.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "TerrofyingController.h"
#import "UIImageView+WebCache.h"
#import "TerrofyingModel.h"
#import "TerrofyingCell.h"
#import "DetailController.h"
#import "TerrListModel.h"
#import "ShowController.h"



@interface TerrofyingController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UIImageView *imageViewH;

@property (nonatomic, strong) NSString *headerStr;


@property (nonatomic, strong) NSMutableArray *dataCollectionArray;

@property (strong, nonatomic) UICollectionView *collectionView;

@end

@implementation TerrofyingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    [self getCollectionData];
    [self createCollectionView];
     [self createHeaderView];
    
    
}
- (NSMutableArray *)dataCollectionArray {
    
    if (_dataCollectionArray == nil) {
        
        _dataCollectionArray = [[NSMutableArray alloc] init];
    }
 return   _dataCollectionArray;
    
}

#pragma mark ===创建createCollectionView
- (void)createCollectionView {
    
    //系统提供自带的布局类
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    //每一个item大小
    flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH / 7 * 2, 135);
    
    //列数, 根据Item的大小和最小间距来
//    flowLayout.minimumInteritemSpacing = 10;
//    
//    //最小行间距 --- 默认值为10
//    flowLayout.minimumLineSpacing = 10;
    

    
    //距离分区边距
    flowLayout.sectionInset = UIEdgeInsetsMake(0, SCREEN_WIDTH / 32, SCREEN_WIDTH / 32, SCREEN_WIDTH / 32);
    
    //创建 CollectionView
   self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 113) collectionViewLayout:flowLayout];
    
    self.collectionView.backgroundColor = [UIColor blackColor];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    //注册 cell
    UINib *nib = [UINib nibWithNibName:@"TerrofyingCell" bundle:nil];
    
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"terrofyingCell"];
    
    //注册分区头
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    
    //注册分区尾
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];
    
    [self.view addSubview:self.collectionView];
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ShowController *showVC = [[ShowController alloc] initWithNibName:@"ShowController" bundle:nil];
    showVC.ids = self.ids;
    
    TerrListModel *listModel = self.dataCollectionArray[indexPath.row];
    showVC.showID = listModel.showID;
    [self.navigationController pushViewController:showVC animated:YES];
    
    
    
}

//返回每个section有多少个Item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return self.dataCollectionArray.count;
}
//返回分区个数 默认一个分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}
//返回分区或者分区尾
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        view.backgroundColor = [UIColor yellowColor];
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT / 10 * 3, SCREEN_WIDTH, SCREEN_HEIGHT / 12 )];
//        lable.backgroundColor = [UIColor magentaColor];
        view.backgroundColor = [UIColor blackColor];
        lable.text = @"漫画列表";
        [view addSubview:self.imageViewH];
        [view addSubview:lable];
        
        return view;
    }
    //    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
    //     view.backgroundColor = [UIColor yellowColor];
    
    
    return  nil;
    
}
//返回collectionView头
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    
    return CGSizeMake(0, SCREEN_HEIGHT / 10 * 4);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TerrofyingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"terrofyingCell" forIndexPath:indexPath];
    TerrListModel *model = [[TerrListModel alloc] init];
    model = self.dataCollectionArray[indexPath.item];
    cell.backgroundColor = [UIColor whiteColor];
    cell.terrModel = model;
    cell.layer.cornerRadius = 3;
    cell.layer.masksToBounds = YES;
    return cell;
}



- (void)createHeaderView {
    self.imageViewH = [[UIImageView alloc] init];
    self.imageViewH.backgroundColor = [UIColor lightGrayColor];

    self.imageViewH.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT / 10 * 3);
    [self.view addSubview:self.imageViewH];
    
}
#pragma mark ===collection请求数据
- (void)getCollectionData {
    
        NSString *urlStr = [NSString stringWithFormat:@"http://apikb.xiaomianguan.org/getList"];
//        NSString *body = @"appc=as_kbmh&hash=729ccececbd686663dc46a985534874e&sort=0&cid=83&resolution=375%2C667&dateline=1470291415022&page=1&deviceToken=nil&appv=1.0.3.100";
    
    NSString *body1 = @"&resolution=375%2C667&dateline=1470291415022&page=1&deviceToken=nil&appv=1.0.3.100";
    
    NSString *body = [NSString stringWithFormat:@"appc=as_kbmh&hash=729ccececbd686663dc46a985534874e&sort=0&cid=%@", self.ids];
    
    NSString *bodyStr = [body stringByAppendingString:body1];
 
    [DownLoad dowmLoadWithUrl:urlStr postBody:bodyStr resultBlock:^(NSData *data) {
        
        if (data != nil) {
            NSDictionary *dictData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@", dictData);
            
            NSLog(@"%@", dictData[@"result"]);
            NSArray *arr = dictData[@"result"][@"list"];
            NSMutableArray *listArr = [NSMutableArray array];
            NSLog(@"%lu", (unsigned long)arr.count);
            
            [self.imageViewH sd_setImageWithURL:[NSURL URLWithString:dictData[@"result"][@"photo"]]];
            
            for (NSDictionary *dict1 in arr) {
                
                TerrListModel *model = [[TerrListModel alloc] init];
                
                [model setValuesForKeysWithDictionary:dict1];
                
                [listArr addObject:model];
             
                }
           
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
               NSArray *alist = [ listArr sortedArrayUsingComparator:^NSComparisonResult(TerrListModel *p2, TerrListModel *p1) {
                    
                    return [p2.updatetime compare:p1.updatetime];
                }];
                
                self.dataCollectionArray = (NSMutableArray *)alist;
                [self.collectionView reloadData];
            });

        
        }else {
            
            NSLog(@"数据为空");
        }
        
        
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

