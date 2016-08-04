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

//左边菜单控制器
@property (nonatomic, strong) UIViewController *leftMenuVc;

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
+ (instancetype)drawerVcWithMainVc:(UIViewController *)mainVc leftMenuVc:(UIViewController *)leftMenuVc leftWidth:(CGFloat)leftWidth{
    
    //创建抽屉控制器
    HMDrawerViewController *drawerVc = [[HMDrawerViewController alloc] init];
    
    drawerVc.mainVc = mainVc;
    drawerVc.leftWidth = leftWidth;
    drawerVc.leftMenuVc = leftMenuVc;
    
    //将左边菜单控制器的view添加到抽屉控制器的view上
    [drawerVc.view addSubview:leftMenuVc.view];
    //将mainVc控制器的view添加到抽屉控制器的view上
    [drawerVc.view addSubview:mainVc.view];
    
    //苹果: 如果两个控制器的view护卫父子关系, 则这两个控制器也必须为父子关系
    [drawerVc addChildViewController:leftMenuVc];
    [drawerVc addChildViewController:mainVc];
    
    
    
    //返回抽屉控制器
    return drawerVc;
    
    
    
}
- (void)openLeftMenu {
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
       
//        NSLog(@"%f", self.leftWidth);
        //设置偏移量
        self.mainVc.view.transform = CGAffineTransformMakeTranslation(self.leftWidth, 0);
        self.leftMenuVc.view.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
        //添加mainVc遮掩按钮
        [self.mainVc.view addSubview:self.coverBtn];
    }];

    
}
- (void)panCoverBtn:(UIPanGestureRecognizer *)pan {
    
    
    //获取屏幕宽度
    CGFloat screen = [UIScreen mainScreen].bounds.size.width;
    //获取X方向拖拽的距离
     CGFloat offsetX = [pan translationInView:pan.view].x;
    if(offsetX > 0) return;
    
    CGFloat distance = self.leftWidth - ABS(offsetX);
    
    //手势是否结束或被取消了
    if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled) {
        //判断主控制器的view的x有没有超过屏幕的一半
        if (self.mainVc.view.frame.origin.x > screen * 0.5) {
            [self openLeftMenu];
        } else {
            
            [self coverBtnAction];
        }
     
    }else if (pan.state == UIGestureRecognizerStateChanged) {
        self.mainVc.view.transform = CGAffineTransformMakeTranslation(MAX(0, distance), 0);
        self.leftMenuVc.view.transform = CGAffineTransformMakeTranslation(-self.leftWidth + distance, 0);
    }
    
}

#pragma mark ===懒加载遮盖按钮
- (UIButton *)coverBtn {
    if (_coverBtn == nil) {
        
        _coverBtn = [[UIButton alloc] init];
//        _coverBtn.alpha = 0.1;
        _coverBtn.backgroundColor = [UIColor clearColor];
        [_coverBtn addTarget:self action:@selector(coverBtnAction) forControlEvents:UIControlEventTouchUpInside];   
        _coverBtn.frame = self.mainVc.view.bounds;
        
        //创建一个拖拽手势
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panCoverBtn:)];
        
        [_coverBtn addGestureRecognizer:pan];
        
    }
    
    return _coverBtn;
}



/**
 *  监听遮盖按钮的点击
 */
- (void)coverBtnAction {
    
    
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
//        NSLog(@"%f", self.leftWidth);
        //CGAffineTransformIdentity:还原view的tramsform
        self.mainVc.view.transform = CGAffineTransformIdentity;
          self.leftMenuVc.view.transform = CGAffineTransformMakeTranslation(-self.leftWidth, 0);
        
    } completion:^(BOOL finished) {
        
        //添加mainVc遮掩按钮
        //移除
        [self.coverBtn removeFromSuperview];
        self.coverBtn = nil;
//        [self.mainVc.view addSubview:self.coverBtn];
    }];

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 默认左边控制器view想做偏移self.lefWidth
    self.leftMenuVc.view.transform = CGAffineTransformMakeTranslation(-self.leftWidth, 0);
    
    //给mainVc的view设置阴影效果    
    self.mainVc.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.mainVc.view.layer.shadowOffset = CGSizeMake(-3, -3);
    self.mainVc.view.layer.shadowOpacity = 0.2;
    self.mainVc.view.layer.shadowRadius = 5;
    
    //给tabBarVc的子控制器的view添加边缘拖拽手势
    for (UIViewController *childVC in self.mainVc.childViewControllers) {
        
        
        [self addScreenEdgePanGestureRecognizerToView:childVC.view];
    }
}

/**
 *  给指定的View添加边缘拖拽手势
 *
 */
- (void)addScreenEdgePanGestureRecognizerToView:(UIView *)view {
    
    UIScreenEdgePanGestureRecognizer *pan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePanGestureRecognizer:)];
    
    //拖左边缘触发
    pan.edges = UIRectEdgeLeft;
    
    //添加手势
    [view addGestureRecognizer:pan];
    
}

- (void)edgePanGestureRecognizer:(UIScreenEdgePanGestureRecognizer *)pan {

//    NSLog(@"%s", __FUNCTION__);
    
    //获取屏幕宽度
    CGFloat screen = [UIScreen mainScreen].bounds.size.width;
    
    //获取x方向拖拽的距离
    CGFloat offsetX = [pan translationInView:pan.view].x;
    

    
    //手势是否结束或被取消了
    if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled) {
        //判断主控制器的view的x有没有超过屏幕的一半
        if (self.mainVc.view.frame.origin.x > screen * 0.5) {
            
            [self openLeftMenu];
        }else {
            
            [self coverBtnAction];
        }
    }else if (pan.state == UIGestureRecognizerStateChanged) {
        //手势一直在识别中...
            self.mainVc.view.transform = CGAffineTransformMakeTranslation(offsetX, 0);
            self.leftMenuVc.view.transform = CGAffineTransformMakeTranslation(-self.leftWidth + offsetX, 0);
        
    }
    
    
    
    
}

/**
 *  切换到指定的控制器
 *
 *  @param destVC
 */
- (void)switchController:(UIViewController *)destVC {
    
    destVC.view.frame = self.mainVc.view.bounds;
    destVC.view.transform = self.mainVc.view.transform;
    
    
    [self.view addSubview:destVC.view];
    [self addChildViewController:destVC];
    self.showingVc = destVC;
//    [self.view bringSubviewToFront:destVC.view];
    
    [self coverBtnAction];
    
    [UIView animateWithDuration:0.25  animations:^{
        destVC.view.transform = CGAffineTransformIdentity;
        
    }];
    
}
- (void)backHome {
    [UIView animateWithDuration:0.25  animations:^{
        self.showingVc.view.transform = CGAffineTransformMakeTranslation(self.view.frame.size.width, 0);
    }completion:^(BOOL finished) {
        
        [self.showingVc removeFromParentViewController];
        [self.showingVc.view removeFromSuperview];
        self.showingVc = nil;
    } ];
 
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
























@end
