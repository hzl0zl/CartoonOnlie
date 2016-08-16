//
//  HMDrawerViewController.m
//  Demo_仿QQ抽屉效果
//
//  Created by zhiling on 16/7/9.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "HMDrawerViewController.h"

@interface HMDrawerViewController ()

@property (nonatomic, strong) UIViewController *showingVc;

//遮盖按钮
@property (nonatomic, strong) UIButton *coverBtn;

//左边菜单控制器最大显示范围
@property (nonatomic, assign) CGFloat leftWidth;

//主控制器
@property (nonatomic, strong) UIViewController *mainVc;



@end

@implementation HMDrawerViewController

+ (instancetype)shareDrawer {
    
    return (HMDrawerViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    
}
/**
 *  快速创建抽屉控制器
 *
 *  @param mainVc     主控器 --> UIViewController
 *  @param leftMenuVc 左边菜单控制器
 *
 *  @return 抽屉控制器
 */
+ (instancetype)drawerVcWithMainVc:(UIViewController *)mainVc{
    
    //创建抽屉控制器
    HMDrawerViewController *drawerVc = [[HMDrawerViewController alloc] init];
    
    drawerVc.mainVc = mainVc;

    //将mainVc控制器的view添加到抽屉控制器的view上
    [drawerVc.view addSubview:mainVc.view];

    [drawerVc addChildViewController:mainVc];
    
    //返回抽屉控制器
    return drawerVc;
    
    
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor magentaColor];
  

   
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
























@end
