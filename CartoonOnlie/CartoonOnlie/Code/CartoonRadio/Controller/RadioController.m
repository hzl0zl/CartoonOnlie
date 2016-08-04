//
//  RadioController.m
//  CartoonOnlie
//
//  Created by zhiling on 16/7/30.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "RadioController.h"
#import "RadioModel.h"
#import "RadioCell.h"
#import "RadioDetailController.h"

@interface RadioController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray  *hot_musicsArr;

@property (nonatomic, strong) NSMutableArray *hot_radiosArr;

@property (nonatomic, strong) NSMutableArray *musicsArr;

//数据
@property (nonatomic, strong) NSDictionary *dataDict;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation RadioController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.translucent = NO;
    [self getData];
    [self createTableView];
    
    
}
- (void)createTableView {
    
    self.tableView = [[UITableView alloc ]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 113) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    UINib *nib = [UINib nibWithNibName:@"RadioCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"radioCell"];
    
    
    
}

//获取tableView的数据
- (void)getData {
    
    [DownLoad dowmLoadWithUrl:@"http://moe.fm/explore?api=json&api_key=74915edacd1a54b1157833bb952f64a5055b78cdc&hot_musics=1&hot_radios=1&musics=1" postBody:nil resultBlock:^(NSData *data) {
        
        if (data != nil) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
//            NSLog(@"%@", dict);
            //做判断
            NSArray *hot_musics = dict[@"response"][@"hot_musics"];
            NSArray *hot_radios = dict[@"response"][@"hot_radios"];
            NSArray *musics = dict[@"response"][@"musics"];
            
            
            for (NSDictionary *hot_musicsDict in hot_musics) {
                
                RadioModel *model = [[RadioModel alloc] init];
                
                [model setValuesForKeysWithDictionary:hot_musicsDict];
                
                [self.hot_musicsArr addObject:model];
            }

            for (NSDictionary *hot_radiosDict in hot_radios) {
                
                RadioModel *model = [[RadioModel alloc] init];
                
                [model setValuesForKeysWithDictionary:hot_radiosDict];
                
                [self.hot_radiosArr addObject:model];
            }
            
            for (NSDictionary *musicsDict in musics) {
                
                RadioModel *model = [[RadioModel alloc] init];
                
                [model setValuesForKeysWithDictionary:musicsDict];
                
                [self.musicsArr addObject:model];
            }

            
            [self.dataDict setValue:self.hot_radiosArr forKey:@"0"];
            [self.dataDict setValue:self.hot_musicsArr forKey:@"1"];
            [self.dataDict setValue:self.musicsArr forKey:@"2"];
            
            
//            NSLog(@"%@", self.dataDict);
            
      dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.tableView reloadData];
            });
            
            
        }else {
            
            NSLog(@"没有数据或者网络繁忙");
        }
       
    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RadioCell *cell = [tableView dequeueReusableCellWithIdentifier:@"radioCell"];
//    cell.backgroundColor = [UIColor magentaColor];
    if (indexPath.section == 0) {
        
     NSArray *arr = [self.dataDict objectForKey:@"0"];
        
        RadioModel *model = arr[indexPath.row];
        
        cell.radioModel = model;
        
        return cell;
        
        
    }else if (indexPath.section == 1) {
        
        NSArray *arr = [self.dataDict objectForKey:@"1"];
        
        RadioModel *model = arr[indexPath.row];
        
        cell.radioModel = model;
        
        return cell;
        
        
    }else {
        
        NSArray *arr = [self.dataDict objectForKey:@"2"];
        
        RadioModel *model = arr[indexPath.row];
        
        cell.radioModel = model;
        
        return cell;
  
    }
    

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    
    return self.dataDict.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        NSArray *arr = [self.dataDict objectForKey:@"0"];
        return arr.count;
        
    }else if (section == 1) {
        
        NSArray *arr = [self.dataDict objectForKey:@"1"];
        return arr.count;
        
    }else {
        
        NSArray *arr = [self.dataDict objectForKey:@"2"];
        return arr.count;
    }

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *label;
    
    if (section == 0) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        label.text = @"热门电台";
        return label;
    }else if (section == 1) {
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        label.text = @"推荐音乐";
        return label;
        
    }else {
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        label.text = @"试听歌曲";
        return label;
        
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RadioDetailController *detailVC = [[RadioDetailController alloc] init];
    
    NSString *section = [NSString stringWithFormat:@"%ld", (long)indexPath.section];
    
    NSArray *arr = [self.dataDict objectForKey:section];
    RadioModel *model = arr[indexPath.row];

    
    detailVC.radioModel = model;
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
    
    
}
- (NSDictionary *)dataDict {
    
    if (_dataDict == nil) {
        
        _dataDict = [[NSMutableDictionary alloc] init];
        
    }
    return _dataDict;
}
- (NSMutableArray *)hot_musicsArr {
    if (_hot_musicsArr == nil) {
        
        _hot_musicsArr = [NSMutableArray array];
    }
    
    return _hot_musicsArr;
}

- (NSMutableArray *)hot_radiosArr {
    if (_hot_radiosArr == nil) {
        
        _hot_radiosArr = [NSMutableArray array];
    }
    
    return _hot_radiosArr;
}


- (NSMutableArray *)musicsArr {
    if (_musicsArr == nil) {
        
        _musicsArr = [NSMutableArray array];
    }
    
    return _musicsArr;
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
