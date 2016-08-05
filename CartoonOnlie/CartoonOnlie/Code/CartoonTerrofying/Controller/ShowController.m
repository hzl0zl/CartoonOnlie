//
//  ShowController.m
//  CartoonOnlie
//
//  Created by zhiling on 16/8/4.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "ShowController.h"
#import "ShowModel.h"
@interface ShowController ()

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView *showView;

@property (nonatomic, strong) NSMutableArray *dataPic;

@end

@implementation ShowController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView.backgroundColor = [UIColor magentaColor];
    
    [self getData];
    
    
}



#pragma mark ===请求数据
- (void)getData {
    NSString *urlStr = [NSString stringWithFormat:@"http://apikb.xiaomianguan.org/getView"];
    NSString *body = @"appc=as_kbmh&hash=351d9c155193cf2dd5387e3ef5a9c144&resolution=375%2C667&id=3871&cid=83&dateline=1470291505543&deviceToken=nil&appv=1.0.3.100";
    
    
    [DownLoad dowmLoadWithUrl:urlStr postBody:body resultBlock:^(NSData *data) {
        
        if (data != nil) {
            NSDictionary *dictData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            
            NSLog(@"%@", dictData);
            NSArray *arr = dictData[@"result"][@"imgs"];
            
            for (NSDictionary *dict in arr) {
                
                ShowModel *model = [[ShowModel alloc] init];
                
                [model setValuesForKeysWithDictionary:dict];
                
                [self.dataPic addObject:model];
                
            }

            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                self.scrollView.contentSize = CGSizeMake(0 , self.dataPic.count * SCREEN_HEIGHT);
                
                for (int i = 0; i < self.dataPic.count; i ++) {
                    
                    self.showView = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT * i, SCREEN_WIDTH, SCREEN_HEIGHT)];
                    ShowModel *model = self.dataPic[i];
                    
                    [self.showView sd_setImageWithURL:[NSURL URLWithString:model.path]];
            
                    [self.scrollView addSubview:self.showView];
                    
                    
                }
     
                
            });
        }else {
            
            NSLog(@"数据为空");
        }

        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)dataPic {
    if (_dataPic == nil) {
        _dataPic = [NSMutableArray array];
    }
    
    return _dataPic;
    
}

@end
