//
//  ReadViewController.m
//  CartoonOnlie
//
//  Created by lanou on 16/8/5.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "ReadViewController.h"


@interface ReadViewController ()

@property (nonatomic, strong) NSMutableArray *imageArray;

@property (nonatomic, strong) UIScrollView *scrollView;


@end

@implementation ReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor brownColor];
    
    [self getData];
   
}


#pragma mark -- 懒加载
- (NSMutableArray *)imageArray
{
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _scrollView;
}

#pragma mark -- 视图即将出现
- (void)viewWillAppear:(BOOL)animated
{
    self.title = [NSString stringWithFormat:@"第 %@ 话", self.model.orderNumber];
    
    self.tabBarController.tabBar.hidden= YES;
    
    self.tabBarController.tabBar.translucent = YES;
}


#pragma mark -- 获取网络数据
- (void)getData
{
    NSString *str = [NSString stringWithFormat:@"http://cache.youqudao.com/phone//%@/lz/%@/config.json", self.model.albumId, self.model.workId];
    
    
    [DownLoad dowmLoadWithUrl:str postBody:nil resultBlock:^(NSData *data) {
        
        if (data != nil) {
            NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            for (int i = 0; i < array.count; i++) {
                
                // 拼接
                NSString *str = [NSString stringWithFormat:@"/%@", array[i]];
                
                NSString *imageUrl = [self.model.onlineUrl stringByAppendingString:str];
                
                [self.imageArray addObject:imageUrl];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.scrollView.contentSize = CGSizeMake(0, self.imageArray.count * SCREEN_HEIGHT);
                
                [self createImageView];
                
                [self.view addSubview:self.scrollView];
                
            });
        }
    }];
}

#pragma mark -- 创建imageView
- (void)createImageView
{
    for (int i = 0; i < self.imageArray.count; i++) {
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake( 0, i * SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
        NSString *imageStr = [self.imageArray[i] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [imageV sd_setImageWithURL:[NSURL URLWithString:imageStr]];
        
        [self.scrollView addSubview:imageV];
        
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
