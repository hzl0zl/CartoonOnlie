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
#import "TerrofyingController.h"
#import "HMDrawerViewController.h"
#import "CartoonTerrofyingDB.h"

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
    
//    NSArray *arr = [[CartoonTerrofyingDB shareDataHandler] allModel];
    
 
        [self getCollectionData];



    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(TerroleftAction)];
    UINib *nib = [UINib nibWithNibName:@"DetailCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"detaiCell"];


}
- (void)TerroleftAction {
    
    [[HMDrawerViewController shareDrawer] openLeftMenu];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    
    
    
}

#pragma mark ===collection请求数据
- (void)getCollectionData {
    
    NSString *urlStr = @"http://baobab.wandoujia.com/api/v1/ranklist.bak?";
    NSString *body = @"strategy=date&categoryName=创意&num=10";
    [DownLoad dowmLoadWithUrl:urlStr postBody:body resultBlock:^(NSData *data) {
        
        if (data != nil) {
            NSDictionary *dictData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"%@",dictData);
            
        
            
        }else {
            
            NSLog(@"数据为空");
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog( @"%@",   self.dataTableViewArray);
            [self.tableView reloadData];
        });
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataTableViewArray.count;
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
    
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TerrofyingController *terrVc = [[TerrofyingController alloc] init];
    
    TerrofyingModel *model = self.dataTableViewArray[indexPath.row];
    
    terrVc.ids = model.ids;
    [self.navigationController pushViewController:terrVc animated:YES];
    
    
}



@end