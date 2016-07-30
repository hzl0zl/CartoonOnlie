//
//  TerrofyingController.m
//  CartoonOnlie
//
//  Created by zhiling on 16/7/30.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "TerrofyingController.h"

@interface TerrofyingController ()

@end

@implementation TerrofyingController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    
    
    
    
}
- (void)getData {
    
    NSString *urlStr = [NSString stringWithFormat:@"http://apikb.xiaomianguan.org/getBranchFoucs"];
    NSString *body = @"deviceToken=nil&hash=3142f5bba043af28dfc75f3f3ccc2065&appc=as_kbmh&appv=1.0.3.100&resolution=375%2C667&dateline=1469846871821";
    [DownLoad dowmLoadWithUrl:urlStr postBody:body resultBlock:^(NSData *data) {
       
        if (data != nil) {
            NSDictionary *dictData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@", dictData);
            
            NSDictionary *str = dictData[@"result"];
            NSLog(@"%@", str[@"jumpdetail"]);
            NSArray *arr = str[@"result"];
            NSString *string = arr[7][@"jumpdetail"];
            NSLog(@"%@", string);
            
        }else {
            
            NSLog(@"数据为空");
        }
        
      
        
        
    }];
    
    
    
    
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
