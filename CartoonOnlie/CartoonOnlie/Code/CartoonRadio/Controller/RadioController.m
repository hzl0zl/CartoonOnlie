//
//  RadioController.m
//  CartoonOnlie
//
//  Created by zhiling on 16/7/30.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "RadioController.h"

@interface RadioController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray  *dataArr;

@property (nonatomic, strong) NSDictionary *dataDict;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation RadioController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self getData];
    
    
}
- (void)createTableView {
    
    self.tableView = [[UITableView alloc ]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:1];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    UINib *nib = [UINib nibWithNibName:@"RadioCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"radioCell"];
    
    
    
}

//获取tableView的数据
- (void)getData {
    
    [DownLoad dowmLoadWithUrl:@"http://moe.fm/explore?api=json&api_key=74915edacd1a54b1157833bb952f64a5055b78cdc&hot_musics=1&hot_radios=1&musics=1&new_musics=0" postBody:nil resultBlock:^(NSData *data) {
        
        if (data != nil) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"%@", dict);
            //做判断
            NSArray *hot_musics = dict[@"response"][@"hot_musics"];
            NSArray *hot_radios = dict[@"response"][@"hot_radios"];
            NSArray *musics = dict[@"response"][@"musics"];
            
            
            NSDictionary *imgDict = hot_radios[1];
            NSDictionary *ddd = imgDict[@"wiki_cover"];
               NSString *str =  ddd[@"small"];
            NSLog(@"%@",str);
            
            for (NSDictionary *dict1 in hot_musics) {
                
                
            }

            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.tableView reloadData];
            });
            
            
        }else {
            
            NSLog(@"没有数据或者网络繁忙");
        }
   
     
     
        
    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    RadioCell *cell = [tableView dequeueReusableCellWithIdentifier:@"radioCell"];
    
//    cell.radioList = self.dataArr[indexPath.row];
    
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.dataArr.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    DetailRadioController *detailVC = [[DetailRadioController alloc] init];
    
//    detailVC.radio = self.dataArr[indexPath.row];
//    
//    [self.navigationController pushViewController:detailVC animated:YES];
    
    
    
}
- (NSDictionary *)dataDict {
    
    if (_dataDict == nil) {
        
        _dataDict = [[NSMutableDictionary alloc] init];
        
    }
    return _dataDict;
}
- (NSMutableArray *)dataArr {
    if (_dataArr == nil) {
        
        _dataArr = [NSMutableArray array];
    }
    
    return _dataArr;
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
