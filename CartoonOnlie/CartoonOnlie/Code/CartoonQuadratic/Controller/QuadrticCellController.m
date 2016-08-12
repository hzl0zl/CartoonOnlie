//
//  QuadrticCellController.m
//  CartoonOnlie
//
//  Created by lanou on 16/8/8.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "QuadrticCellController.h"
#import "QuadriticCellModel.h"
#import "QuadraticCellTableViewCell.h"
#import "QuadraticWebController.h"

@interface QuadrticCellController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) UISegmentedControl *segmented;

@property (nonatomic,strong) UIView *headerView;

//数据源
@property (nonatomic,strong) NSMutableArray *QuadraticArry;
//头部视图_图片
@property (nonatomic,strong) NSString *headerImage;


@end

@implementation QuadrticCellController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self LoadData];
 
    
    
}

#pragma mark 初始化

-(UITableView *)tableView
{
    if (_tableView ==nil) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
        UINib *nib = [UINib nibWithNibName:@"QuadraticCellTableViewCell" bundle:nil];
        [_tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:_tableView];


    }
  return _tableView;
    
}

-(NSMutableArray *)QuadraticArry
{
    if (_QuadraticArry == nil) {
        _QuadraticArry = [[NSMutableArray alloc]init];
    }
    return _QuadraticArry;
}

#pragma mark 数据解析
-(void)LoadData
{
    
    NSString *url = [NSString stringWithFormat:@"http://api.kuaikanmanhua.com/v1/topics/%@?sort=0",self.urlID];
    
    [DownLoad dowmLoadWithUrl:url postBody:nil resultBlock:^(NSData *data) {
       
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
       
        //头视图赋值
        self.headerImage = dic[@"data"][@"cover_image_url"];
        
        NSArray *arr = dic[@"data"][@"comics"];
        
        
        for (NSDictionary *dic1 in arr) {
            
            QuadriticCellModel *model = [[QuadriticCellModel alloc]init];
            
            model.url = dic1[@"url"];
            
            [model setValuesForKeysWithDictionary:dic1];
            
            [self.QuadraticArry addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
            
              [self creatHaederAndUIsegmented];
        });
    }];
    
    
}




#pragma mark 创建头部视图
-(void)creatHaederAndUIsegmented
{
    
    //创建并添加头部视图
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    
    UIImageView *image = [[UIImageView alloc]init];
        image.frame = CGRectMake(0, 0, SCREEN_WIDTH, 150);
    [image sd_setImageWithURL:[NSURL URLWithString:self.headerImage]];
        [self.headerView addSubview:image];
    
        self.tableView.tableHeaderView = self.headerView;
    
}


#pragma mark TableView 实现方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.QuadraticArry.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuadraticCellTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    QuadriticCellModel *model = self.QuadraticArry[indexPath.row];
    
    cell.model = model;
    
    return cell;
}

//点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuadraticWebController *VC = [[QuadraticWebController alloc]init];
    
    self.hidesBottomBarWhenPushed=YES;
    
    QuadriticCellModel *model = self.QuadraticArry[indexPath.row];
 
    VC.model_url = model.url;
    
    [self.navigationController pushViewController:VC animated:YES];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  100;
}

@end
