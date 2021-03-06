//
//  HMDrawerViewController.h
//  Demo_仿QQ抽屉效果
//
//  Created by zhiling on 16/7/9.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMDrawerViewController : UIViewController
/**
 *  获取抽屉控制器
 *
 *  @return 
 */
+ (instancetype)shareDrawer;

/**
 *  快速创建抽屉控制器
 *
 *  @param mainVc     主控器 --> UIViewController
 *  @param leftMenuVc 左边菜单控制器
 *  @param leftWidth  左边菜单控制器显示的最大范围
 *  @return 抽屉控制器
 */
+ (instancetype)drawerVcWithMainVc:(UIViewController *)mainVc;



@end
