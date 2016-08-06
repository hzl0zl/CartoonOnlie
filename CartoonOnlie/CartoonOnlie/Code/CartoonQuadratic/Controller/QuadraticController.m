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
#import "QuadraticWebController.h"

@interface QuadraticController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tabelView;

//数据源
@property (nonatomic,strong) NSMutableArray *quadraticArry;
//标题
@property (nonatomic,strong) NSMutableArray *titleArry;


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

#pragma mark 初始化
-(NSMutableArray *)quadraticArry
{
    if (_quadraticArry == nil) {
        _quadraticArry = [[NSMutableArray alloc]init];
    }
    return _quadraticArry;
}

-(NSMutableArray *)titleArry
{
    if (_titleArry == nil) {
        _titleArry = [[NSMutableArray alloc]init];
    }
    return _titleArry;
}

#pragma  mark 视图及数据处理
-(void)creatTblewView
{
    self.tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    
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
        
        NSMutableArray *arry = dic[@"data"][@"comics"];
            
        for (NSDictionary *dic1 in arry) {
            
            QuadraticModel *model = [[QuadraticModel alloc]init];
            
            //分区尾标题
            model.title = dic1[@"title"];
            //分区头标题
            self.titleArry =  dic1[@"topic"][@"title"];
            //分区头作者
            NSDictionary *dic2 = dic1[@"topic"][@"user"];
            model.nickname = dic2[@"nickname"];
            
            //漫画内容
            model.url = dic1[@"url"];

            [model setValuesForKeysWithDictionary:dic1];
            
            [self.quadraticArry addObject:model];
        }
            
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

#pragma mark tableView 设置
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 1;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    QuadraticTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    QuadraticModel *model = self.quadraticArry[indexPath.section];
    cell.model = model;
    return cell;

}
//返回分区数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
 
  return   self.quadraticArry.count;

}

#pragma mark 分区头部及尾部相关设置

//头分区
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 25)];
    
    UILabel *laber = [[UILabel alloc]initWithFrame:CGRectMake(15, 8, 45, 20)];

    UILabel *laber1 = [[UILabel alloc]initWithFrame:CGRectMake(75, 8, 130, 20)];
   
    UILabel *laber2 = [[UILabel alloc]initWithFrame:CGRectMake(240, 8, 70, 20)];
    
    laber2.backgroundColor = [UIColor orangeColor];
    
    view.backgroundColor = [UIColor redColor];
    
    laber.font = [UIFont systemFontOfSize:13];
    
    laber1.font = [UIFont systemFontOfSize:13];
    
    laber1.backgroundColor = [UIColor grayColor];
    
    QuadraticModel *model = self.quadraticArry[section];
   
    laber.text = model.label_text;
    
    
   
//    laber1.text = self.titleArry[section];
    
    laber2.text = model.nickname;
    
 
    [view addSubview:laber2];
    
    [view addSubview:laber1];
    
    [view addSubview:laber];
    
    return view;
}

//尾分区
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 25)];
    
    UILabel *laber = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, 150, 20)];
    
    view.backgroundColor = [UIColor whiteColor];
    
    laber.font = [UIFont systemFontOfSize:10];
    laber.backgroundColor = [UIColor brownColor];
    
    QuadraticModel *model = self.quadraticArry[section];
    
    laber.text = model.title;
    
    [view addSubview:laber];
    
    return view;
}
#pragma  mark 点击cell响应方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    QuadraticWebController *webVC = [[QuadraticWebController alloc]init];
    [self.navigationController pushViewController:webVC animated:YES];
    
    //传值
     webVC.model = self.quadraticArry[indexPath.section];
    
    
}


#pragma mark tableView 返回高度
//返回cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}

//返回头
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
   
    return 30;
}

//返回尾
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 30;
}



@end
