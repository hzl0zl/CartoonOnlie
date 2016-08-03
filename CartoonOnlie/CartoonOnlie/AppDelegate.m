//
//  AppDelegate.m
//  CartoonOnlie
//
//  Created by zhiling on 16/7/30.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "AppDelegate.h"
#import "HMDrawerViewController.h"
#import "HMLeftMenuTableViewController.h"
#import "FunnyController.h"
#import "QuadraticController.h"
#import "RadioController.h"
#import "DetailController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
- (UIViewController *)viewControllerWithTitle:(NSString *)title normalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage class:(Class)class{
    
    UIViewController *vc  = [[class alloc] init];
    //设置标题
    vc.title = title;
    
    //设置普通状态图片
    UIImage *imageNormal = [UIImage imageNamed:normalImage];
    imageNormal = [imageNormal imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.image = imageNormal;
    
    UIImage *imageSelected = [UIImage imageNamed:selectedImage];
    imageSelected = [imageSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    vc.tabBarItem.selectedImage = imageSelected;
    
    return vc;
}


- (UITabBarController *)createTabbarController{
    
    UITabBarController *tabbarController = [[UITabBarController alloc] init];
    
    //创建多个视图控制器
    
    QuadraticController *firstVC =  (QuadraticController *)[self viewControllerWithTitle:@"one" normalImage:@"home.png" selectedImage:@"home_fill.png" class:[QuadraticController class]];
    
    FunnyController *secondVC = (FunnyController *)[self viewControllerWithTitle:@"two" normalImage:@"fanli.png" selectedImage:@"fanli_fill.png" class:[FunnyController class]];
    
    
    DetailController *thirdVC = (DetailController *)[self viewControllerWithTitle:@"恐怖漫画屋" normalImage:@"remind.png" selectedImage:@"remind_fill.png" class:[DetailController class]];
    
    RadioController *fourVC = (RadioController *)[self viewControllerWithTitle:@"动漫电台" normalImage:@"lbs.png" selectedImage:@"lbs_fill.png" class:[RadioController class]];
    
    
    UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:firstVC];
    
    UINavigationController *secondNav = [[UINavigationController alloc] initWithRootViewController:secondVC];
    
    
     UINavigationController *thridNav = [[UINavigationController alloc] initWithRootViewController:thirdVC];
    
     UINavigationController *fourNav = [[UINavigationController alloc] initWithRootViewController:fourVC];
    
    
    tabbarController.viewControllers = @[firstNav, secondNav, thridNav, fourNav];
    
    
    //设置Item的选中颜色
    tabbarController.tabBar.tintColor = [UIColor blackColor];
    
    
    
    //设置tabbar的颜色 默认半透明
    //    mainTabbar.tabBar.barTintColor = [UIColor grayColor];
    //    mainTabbar.tabBar.frame = CGRectMake(20, 20, 40, 40);
    
    tabbarController.tabBar.translucent = NO;
    
    //tabbar 高度 --49
    //当tabbar不是半透明时, 被管理的控制器根视图高度要-49;
    //隐藏
    tabbarController.tabBar.hidden = NO;
    
    //角标
    firstVC.tabBarItem.badgeValue = @"100";
    
    //设置tabbarController
//    tabbarController.delegate = self;
    
#pragma mark 同--UINavigationBara 和UITabbar的风格
    
    // 设置所有导航栏的背景颜色
    //    [[UINavigationBar appearance] setBarTintColor:[UIColor orangeColor]];
    //
    //    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    //
    //    [[UITabBar appearance] setTintColor:[UIColor magentaColor]];
    return tabbarController;
    
}




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //    self.window.backgroundColor = [UIColor redColor];
    //创建左右菜单控制器
    HMLeftMenuTableViewController *leftMenuVc = [[HMLeftMenuTableViewController alloc] init];
    
    //加载storyboard
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    //创建箭头指向的控制器 -- UITabBarController
//    UITabBarController *tabBarVc = sb.instantiateInitialViewController;
    
    //设置窗口根控制器
    self.window.rootViewController = [HMDrawerViewController drawerVcWithMainVc:[self createTabbarController] leftMenuVc:leftMenuVc leftWidth:260];
    
    //显示窗口
    [self.window makeKeyAndVisible];

    return YES;

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
