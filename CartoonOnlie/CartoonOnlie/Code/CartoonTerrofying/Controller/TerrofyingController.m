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
    [self getHeaderViewData];
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
    flowLayout.itemSize = CGSizeMake(110, 140);
    
    //列数, 根据Item的大小和最小间距来
    flowLayout.minimumInteritemSpacing = 10;
    
    //最小行间距 --- 默认值为10
    flowLayout.minimumLineSpacing = 10;
    
    //距离分区边距
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    //创建 CollectionView
   self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) collectionViewLayout:flowLayout];
    
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
    
    DetailController *detailVC = [[DetailController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
    
    
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
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 40)];
        lable.backgroundColor = [UIColor magentaColor];
        view.backgroundColor = [UIColor blackColor];
        lable.text = @"恐怖漫画";
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
    
    
    return CGSizeMake(0, 250);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TerrofyingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"terrofyingCell" forIndexPath:indexPath];
    TerrofyingModel *model = [[TerrofyingModel alloc] init];
    model = self.dataCollectionArray[indexPath.item];
    cell.terrModel = model;
    cell.layer.cornerRadius = 3;
    cell.layer.masksToBounds = YES;
    return cell;
}

- (void)createHeaderView {
    self.imageViewH = [[UIImageView alloc] init];
    self.imageViewH.backgroundColor = [UIColor lightGrayColor];

    self.imageViewH.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
    [self.view addSubview:self.imageViewH];
    
}
#pragma mark ===请求数据
- (void)getHeaderViewData {
    
    
    
    NSString *urlStr = [NSString stringWithFormat:@"http://apikb.xiaomianguan.org/getBranchFoucs"];
    NSString *body = @"deviceToken=nil&hash=3142f5bba043af28dfc75f3f3ccc2065&appc=as_kbmh&appv=1.0.3.100&resolution=375%2C667&dateline=1469846871821";
    [DownLoad dowmLoadWithUrl:urlStr postBody:body resultBlock:^(NSData *data) {
       
        if (data != nil) {
            NSDictionary *dictData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray *arr1 = dictData[@"result"];
            
            NSDictionary *dict1 = [arr1 firstObject];
            self.headerStr = dict1[@"img"];
            
        }else {
            
            NSLog(@"数据为空");
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [ self.imageViewH sd_setImageWithURL:[NSURL URLWithString:self.headerStr]];
           
        });

    }];
}
#pragma mark ===collection请求数据
- (void)getCollectionData {
    
    NSString *urlStr = [NSString stringWithFormat:@"http://apikb.xiaomianguan.org/getListCollect"];
    NSString *body = @"msgNum=83-1469842200%7C80-1469499300%7C79-1469257200%7C78-1469328300%7C76-1469773800%7C73-1469351400%7C71-1469684100%7C70-1469769900%7C65-1469242800%7C63-1468313640%7C62-1469589600%7C61-1457430340%7C60-1453365183%7C59-1453279023%7C58-1469775060%7C57-1469515440%7C55-1451204335%7C54-1466066100%7C53-1469514900%7C49-1469436300%7C48-1469322000%7C43-1466318700%7C42-1469589300%7C41-1463814000%7C38-1469431800%7C19-1441681200%7C14-1469785500%7C&hash=ab0e02ddedd32337d38313632ee65d6a&appc=as_kbmh&deviceToken=nil&dateline=1469861501537&page=1&resolution=375%2C667&appv=1.0.3.100";
    [DownLoad dowmLoadWithUrl:urlStr postBody:body resultBlock:^(NSData *data) {
        
        if (data != nil) {
            NSDictionary *dictData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//            NSLog(@"%@", dictData);
            NSLog(@"%@", dictData[@"result"]);
            NSArray *arr = dictData[@"result"];
            
            NSLog(@"%@", arr);
            for (NSDictionary *dict1 in arr) {
                
                TerrofyingModel *model = [[TerrofyingModel alloc] init];
                
                [model setValuesForKeysWithDictionary:dict1];
                
                [self.dataCollectionArray addObject:model];
             
                }
        
        }else {
            
            NSLog(@"数据为空");
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog( @"%@",   self.dataCollectionArray);
            [self.collectionView reloadData];
        });
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

