//
//  SgementController.m
//  CartoonOnlie
//
//  Created by lanou on 16/8/6.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "SgementController.h"
#import "QuadraticController.m"
#import "MainQuadraticViewController.h"

@interface SgementController ()

@property (nonatomic, strong)QuadraticController *quaVC;

@property (nonatomic, strong) MainQuadraticViewController *mainQuaVC;



@end

@implementation SgementController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createView];
    
    [self creatUIsegmented];
    
    
}
- (void)createView {
    
    self.quaVC = [[QuadraticController alloc] init];
    self.quaVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:self.quaVC.view];
    self.mainQuaVC = [[MainQuadraticViewController alloc] init];
       self.mainQuaVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    [self.view addSubview:self.mainQuaVC.view];
    
    
}

//创建UIsegmented
-(void)creatUIsegmented
{
    UISegmentedControl *segmented = [[UISegmentedControl alloc]initWithItems:@[@"首页",@"推荐"]];
    
    //圆角
    segmented.layer.masksToBounds = YES;
    //圆角度数
    segmented.layer.cornerRadius = 12.5;
    //设置边框
    segmented.layer.borderWidth = 1;
    
    segmented.selectedSegmentIndex = 0;
    
    segmented.frame = CGRectMake(50, 100, 50, 25);
    
    [self.navigationController.navigationBar.topItem setTitleView:segmented];
    
    [segmented addTarget:self action:@selector(SwitchView:) forControlEvents:UIControlEventValueChanged];
}
//segmented 按钮方法
-(void)SwitchView:(UISegmentedControl *)index
{
    [index titleForSegmentAtIndex:index.selectedSegmentIndex];
    
    switch (index.selectedSegmentIndex) {
        case 0:
            
            [self.view bringSubviewToFront:self.mainQuaVC.view];
            break;
            
        case 1:
            [self.view bringSubviewToFront:self.quaVC.view];
            
            break;
            
        default:
            break;
    }
    
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