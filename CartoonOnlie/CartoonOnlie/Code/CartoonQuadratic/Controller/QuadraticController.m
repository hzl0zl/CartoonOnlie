//
//  QuadraticController.m
//  CartoonOnlie
//
//  Created by zhiling on 16/7/30.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "QuadraticController.h"
#import "HMDrawerViewController.h"
#import "QuadraticTableViewCell.h"
#import "QuadraticModel.h"
@interface QuadraticController ()<UITableViewDelegate,UITableViewDataSource>

//数据源
@property (nonatomic,strong) NSMutableArray *quadraticArry;

@property (nonatomic,strong) UITableView *tabelView;

@end

@implementation QuadraticController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor magentaColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(leftAction)];
    
    [self creatTblewView];
    
    [self loadData];
}


- (void)leftAction {
    
    [[HMDrawerViewController shareDrawer] openLeftMenu];
    
    
}

-(NSMutableArray *)quadraticArry
{
    if (_quadraticArry == nil) {
        _quadraticArry = [[NSMutableArray alloc]init];
    }
    return _quadraticArry;
}

-(void)creatTblewView
{
    self.tabelView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    self.tabelView.delegate = self;
    self.tabelView.dataSource = self;
    
    UINib *nib = [UINib nibWithNibName:@"QuadraticTableViewCell" bundle:nil];
    
    [self.tabelView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview: self.tabelView];
}


-(void)loadData
{
    
   NSString *url = @"http://api.kuaikanmanhua.com/v1/daily/comic_lists/0?since=0";
    
    [DownLoad dowmLoadWithUrl:url postBody:nil resultBlock:^(NSData *data) {
        
        if (data != nil) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSArray *arry = dic[@"data"][@"comics"];

        for (NSDictionary *dic1 in arry) {
            
            QuadraticModel *model = [[QuadraticModel alloc]init];
            
            [model setValuesForKeysWithDictionary:dic1];
            
            [self.quadraticArry addObject:model];
            
        }
//            NSLog(@"*******÷/***********%@",self.quadraticArry);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tabelView reloadData];
        });
        }
        else
        {
            NSLog(@"网络繁忙请稍后再试");
        }

    }];

   
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.quadraticArry.count;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuadraticTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    QuadraticModel *model = self.quadraticArry[indexPath.row];
    cell.model = model;
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

@end
