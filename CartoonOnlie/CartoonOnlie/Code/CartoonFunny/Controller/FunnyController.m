//
//  FunnyController.m
//  CartoonOnlie
//
//  Created by zhiling on 16/7/30.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "FunnyController.h"
#import "FunListCell.h"
#import "FunListModel.h"
#import "SDCycleScrollView.h"


@interface FunnyController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *funList;


@end



@implementation FunnyController



#pragma mark -- 懒加载

- (NSMutableArray *)funList

{
    
    if (_funList == nil) {
        
        _funList = [NSMutableArray array];
        
    }
    
    return _funList;
    
}



- (UITableView *)tableView

{
    
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:0];
        
        _tableView.delegate = self;
        
        _tableView.dataSource = self;
        
        UINib *nib = [UINib nibWithNibName:@"FunListCell" bundle:nil];
        
        [_tableView registerNib:nib forCellReuseIdentifier:@"funlistcell"];
        
    }
    
    return _tableView;
    
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    self.tableView.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:self.tableView];
    
    [self getData];
    
}

- (void)getData
{
    [DownLoad dowmLoadWithUrl:FUNNYLIST postBody:nil resultBlock:^(NSData *data) {
        if (data == nil) {
            return;
        }else
        {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            NSArray *array = dict[@"work"];
            
            NSMutableArray *scrollArray = [NSMutableArray array];
            
            for (NSDictionary *dic in array) {
                
                [scrollArray addObject:dic[@"cover"][@"url"]];
                
                FunListModel *model = [[FunListModel alloc] init];
                model.url = dic[@"cover"][@"url"];
                
                [model setValuesForKeysWithDictionary:dic];
                
                [self.funList addObject:model];
            }
            NSLog(@"%@", self.funList);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150) delegate:nil placeholderImage:nil];
                
                cycleScrollView.imageURLStringsGroup = scrollArray;
                
                self.tableView.tableHeaderView = cycleScrollView;
                
                [self.tableView reloadData];
            });
        }
        
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    return self.funList.count;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    FunListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"funlistcell"];
    
    FunListModel *model = self.funList[indexPath.row];
    
    cell.listModel = model;
    
    return cell;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    return 120.f;
    
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
    
}



/*
 
 #pragma mark - Navigation
 
 
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 
 // Get the new view controller using [segue destinationViewController].
 
 // Pass the selected object to the new view controller.
 
 }
 
 */



@end
