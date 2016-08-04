//
//  RadioDetailController.m
//  CartoonOnlie
//
//  Created by zhiling on 16/8/3.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "RadioDetailController.h"
#import "RadioDetaiModel.h"
#import "RadioDetailCell.h"
#import "RadioPlayController.h"


@interface RadioDetailController ()

@property (nonatomic, strong) NSMutableArray *dataArr;



@end

@implementation RadioDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    
    UINib *nib = [UINib nibWithNibName:@"RadioDetailCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"radioDetailCell"];
    
 
}

- (void)getData {
    //    NSString *url = @"http://moe.fm/listen/playlist?api=json&api_key=74915edacd1a54b1157833bb952f64a5055b78cdc&page=1&perpage=30&radio=45835";
    
    NSString *url = [NSString stringWithFormat:@"http://moe.fm/listen/playlist?api=json&api_key=74915edacd1a54b1157833bb952f64a5055b78cdc&page=1&perpage=30&radio=%@", self.radioModel.wiki_id];
    
    [DownLoad dowmLoadWithUrl:url postBody:nil resultBlock:^(NSData *data) {
        if (data != nil) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@", dict);
            NSArray *arr = dict[@"response"][@"playlist"];
            
            for (NSDictionary *dict1 in arr) {
                
                RadioDetaiModel *model = [[RadioDetaiModel alloc] init];
                
                [model setValuesForKeysWithDictionary:dict1];
                
                [self.dataArr addObject:model];
            }
            
            NSLog(@"%@", self.dataArr);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.tableView reloadData];
                
            });
            
        }else {
            
            NSLog(@"网络繁忙!!!");
        }
        
    }];
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RadioPlayController *playVC = [[RadioPlayController alloc] init];

//    RadioDetaiModel *model = self.dataArr[indexPath.row];
    playVC.number = indexPath.row;
    playVC.musics = self.dataArr;
    
    [self.navigationController pushViewController:playVC animated:YES];
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RadioDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"radioDetailCell"];
    
    RadioDetaiModel *model = self.dataArr[indexPath.row];
    
    cell.radioDetailModel = model;
    cell.imageStr = self.radioModel.wiki_cover[@"small"];
    return cell;
}

- (NSMutableArray *)dataArr {
    
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    
    return _dataArr;
    
}

@end