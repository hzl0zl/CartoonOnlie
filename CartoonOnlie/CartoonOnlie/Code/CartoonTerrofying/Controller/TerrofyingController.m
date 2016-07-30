//
//  TerrofyingController.m
//  CartoonOnlie
//
//  Created by zhiling on 16/7/30.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "TerrofyingController.h"

@interface TerrofyingController ()

@property (nonatomic, strong) UIImageView *imageViewH;
@property (nonatomic, strong) UIImage *imgH;
@end

@implementation TerrofyingController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    
    
    
    
}

- (void)createHeaderView {
    
//    self.imageViewH = [[UIImageView alloc] initWithImage:self.imgH];
//    self.imageViewH.frame = CGRectMake(0, 0, <#CGFloat width#>, <#CGFloat height#>)
    
}

- (void)getData {
    
    NSString *urlStr = [NSString stringWithFormat:@"http://apikb.xiaomianguan.org/getBranchFoucs"];
    NSString *body = @"deviceToken=nil&hash=3142f5bba043af28dfc75f3f3ccc2065&appc=as_kbmh&appv=1.0.3.100&resolution=375%2C667&dateline=1469846871821";
    [DownLoad dowmLoadWithUrl:urlStr postBody:body resultBlock:^(NSData *data) {
       
        if (data != nil) {
            NSDictionary *dictData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
//            NSLog(@"%@", dictData);
            
            NSArray *arr1 = dictData[@"result"];
            
            NSDictionary *dict1 = arr1[0];
            NSString *string = dict1[@"jumpdetail"];
            NSLog(@"%@", string);
            NSLog(@"%@", dict1[@"img"]);
            
        }else {
            
//            NSLog(@"数据为空");
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

