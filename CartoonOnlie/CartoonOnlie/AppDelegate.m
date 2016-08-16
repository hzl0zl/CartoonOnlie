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
#import "UMSocial.h"
#import "UMSocialSinaSSOHandler.h"
#import "RadioController.h"
#import "AudioPlayerController.h"
#import "ComicStoreViewController.h"
#import "RealReachability.h"
@interface AppDelegate ()

@property (nonatomic ,strong) AudioPlayerController *palyer;

@end

@implementation AppDelegate

- (AudioPlayerController *)palyer {
    
    if (_palyer == nil) {
        
        _palyer = [AudioPlayerController audioPlayerController];
        
    }
    
    return  _palyer;
}


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
    

    
    ComicStoreViewController *firstVC=(ComicStoreViewController *)[self viewControllerWithTitle:@"二次元漫画" normalImage:@"01" selectedImage:nil class:[ComicStoreViewController class]];
    
    FunnyController *secondVC = (FunnyController *)[self viewControllerWithTitle:@"搞笑一刻" normalImage:@"07" selectedImage:nil class:[FunnyController class]];
    
//    
    
    RadioController *thirdVC = (RadioController *)[self viewControllerWithTitle:@"Cartoon Radio" normalImage:@"06" selectedImage:nil class:[RadioController class]];
    
    UIViewController *fourVC = (UIViewController *)[self viewControllerWithTitle:@"我的设置" normalImage:@"08" selectedImage:nil class:[UIViewController class]];
    UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:firstVC];
    
    UINavigationController *secondNav = [[UINavigationController alloc] initWithRootViewController:secondVC];
    
    
    
     UINavigationController *thridNav = [[UINavigationController alloc] initWithRootViewController:thirdVC];
    
    UINavigationController *fourNav = [[UINavigationController alloc] initWithRootViewController:fourVC];
    
    tabbarController.viewControllers = @[firstNav, secondNav,  thridNav, fourNav];
    
    
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
//    firstVC.tabBarItem.badgeValue = @"100";
    
    //设置tabbarController
//    tabbarController.delegate = self;
    
#pragma mark 同--UINavigationBara 和UITabbar的风格
    
    // 设置所有导航栏的背景颜色
//        [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    //
    //    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    //
    //    [[UITabBar appearance] setTintColor:[UIColor magentaColor]];
    return tabbarController;
    
}

- (BOOL) canBecomeFirstResponder {
    return YES;
}

- (void) remoteControlReceivedWithEvent:(UIEvent *) receivedEvent{
    if (receivedEvent.type == UIEventTypeRemoteControl) {
        switch (receivedEvent.subtype) {
            case UIEventSubtypeRemoteControlPause:
                //点击了暂停
                [self.palyer playerStatus];
                break;
            case UIEventSubtypeRemoteControlNextTrack:
                //点击了下一首
                [self.palyer theNextSong];
                break;
            case UIEventSubtypeRemoteControlPreviousTrack:
                //点击了上一首
                [self.palyer inASong];
                break;
            case UIEventSubtypeRemoteControlPlay:
                //点击了播放
                [self.palyer playerStatus];
                break;
            default:
                break;
        }
    }
}




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
     [GLobalRealReachability startNotifier];
    //开启远程控制
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
    
#pragma mark === 
    
    //初始化友盟分享
    [UMSocialData setAppKey:@"57a5423267e58ebd7000281e"];
    
    //添加新浪分享初始化
    //1、新浪应用的APPkey
    //2、新浪应用的APP secret
    //2、回调地址
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"1902776577" secret:@"919c3c135dd20f98eb665158d31dbc26" RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    
    //创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //    self.window.backgroundColor = [UIColor redColor];
    //创建左右菜单控制器
//    HMLeftMenuTableViewController *leftMenuVc = [[HMLeftMenuTableViewController alloc] init];
//    leftMenuVc.view.frame = CGRectMake(0, 0, SCREEN_WIDTH / 3 * 2, SCREEN_HEIGHT);
    
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:[self createTabbarController]];
    //设置窗口根控制器
    self.window.rootViewController = navVC;
    
    //显示窗口
    [self.window makeKeyAndVisible];
    
//    UINavigationBar *navigationBar = [UINavigationBar appearance];
//    UIImage *image = [UIImage imageNamed:@"menu_bk_partten"];
//    [navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
//    [navigationBar setTintColor:[[UIColor whiteColor]colorWithAlphaComponent:0.8]];
//    navigationBar.translucent = NO;
//    navigationBar.titleTextAttributes = @{NSStrokeColorAttributeName: [[UIColor whiteColor]colorWithAlphaComponent:0.8],
//                                          NSFontAttributeName: [UIFont boldSystemFontOfSize:15]
//                                          };

    
    return YES;

}




- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
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
