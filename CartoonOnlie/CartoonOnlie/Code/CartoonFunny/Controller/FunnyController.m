//
//  FunnyController.m
//  CartoonOnlie
//
//  Created by zhiling on 16/7/30.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "FunnyController.h"



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
        
        [self.view addSubview:_tableView];
        
    }
    
    return _tableView;
    
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    return self.funList.count;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"funListCell"];
    
    
    
    
    
    return cell;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    return 80.f;
    
}









- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
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
