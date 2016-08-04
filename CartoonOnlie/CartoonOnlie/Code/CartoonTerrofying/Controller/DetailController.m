//
//  DetailController.m
//  CartoonOnlie
//
//  Created by zhiling on 16/7/30.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "DetailController.h"
#import "UIImageView+WebCache.h"
#import "TerrofyingModel.h"
#import "DetailCell.h"

@interface DetailController ()

@property (nonatomic, strong) UIImageView *imageViewH;

@property (nonatomic, strong) NSString *headerStr;

@property (nonatomic, strong) NSMutableArray *dataTableViewArray;

@end

@implementation DetailController

- (NSMutableArray *)dataTableViewArray {
    
    if (_dataTableViewArray == nil) {
        
        _dataTableViewArray = [[NSMutableArray alloc] init];
    }
    
    return _dataTableViewArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"DetailCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"detaiCell"];
    [self createHeaderView];
    [self getCollectionData];
    [self getHeaderViewData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    
    
    
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
    
    
//    NSString *urlStr = [NSString stringWithFormat:@"http://apikb.xiaomianguan.org/getView"];
//    NSString *body = @"appc=as_kbmh&hash=563a8b7f97c87d11d4ab6badd51a3940&resolution=375%2C667&id=3871&cid=83&dateline=1470235389847&deviceToken=nil&appv=1.0.3.100";
    
    [DownLoad dowmLoadWithUrl:urlStr postBody:body resultBlock:^(NSData *data) {
        
        if (data != nil) {
            NSDictionary *dictData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                        NSLog(@"%@", dictData);
            NSLog(@"%@", dictData[@"result"]);
            NSArray *arr = dictData[@"result"];
            
            NSLog(@"%@", arr);
            for (NSDictionary *dict1 in arr) {
                
                TerrofyingModel *model = [[TerrofyingModel alloc] init];
                
                [model setValuesForKeysWithDictionary:dict1];
                
                [self.dataTableViewArray addObject:model];
                
            }
            
        }else {
            
            NSLog(@"数据为空");
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog( @"%@",   self.dataTableViewArray);
            [self.tableView reloadData];
        });
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataTableViewArray.count;
}
- (void)createHeaderView {
    self.imageViewH = [[UIImageView alloc] init];
    self.imageViewH.backgroundColor = [UIColor lightGrayColor];
    
    self.imageViewH.frame = CGRectMake(0, 0, SCREEN_WIDTH, 160);
    //    [self.view addSubview:self.imageViewH];
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    
    return self.imageViewH;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"detaiCell";
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    TerrofyingModel *model = self.dataTableViewArray[indexPath.row];
    
    cell.terrModel = model;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 76;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 160;
}

@end