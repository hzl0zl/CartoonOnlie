//
//  CollectionController.m
//  CartoonOnlie
//
//  Created by lanou on 16/8/6.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "CollectionController.h"
#import "CollectionCell.h"
#import "DataHandler.h"
#import "CollectionModel.h"
#import "FunnyDetailViewController.h"

@interface CollectionController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation CollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getData];
    
    
    NSLog(@"/////////////%@", self.model.name);
    
    UINib *nib = [UINib nibWithNibName:@"CollectionCell" bundle:nil];
    
    [self.tableView registerNib:nib forCellReuseIdentifier:@"collectioncell"];
}

// 获取网络数据
- (void)getData
{
    [DownLoad dowmLoadWithUrl:FUNNYLIST postBody:FUNNYLISTPOST resultBlock:^(NSData *data) {
        if (data == nil) {
            return;
        }else
        {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            NSArray *array = dict[@"data"][@"list"];
            
            for (NSDictionary *dic in array) {
                
                CollectionModel *model = [[CollectionModel alloc] init];
                
                if ([self.dataArray containsObject:model.name]) {
                    [model setValuesForKeysWithDictionary:dic];
                    
                    //                NSURL *url = [NSURL URLWithString:model.coverPic];
                    [self.dataArray addObject:model];
                }
                
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.tableView reloadData];
            });
        }
    }];
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.f;
}

// 视图即将出现
- (void)viewWillAppear:(BOOL)animated
{
    
//    self.tableView.separatorStyle = NO;
    self.dataArray = [NSMutableArray arrayWithArray:[[DataHandler shareDataHandler] allCartoon]];
    
    [self.tableView reloadData];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"collectioncell" forIndexPath:indexPath];
    
    CollectionModel *model = self.dataArray[indexPath.row];
    
    cell.model = model;
    return cell;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CollectionModel *model = self.dataArray[indexPath.row];
    
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[DataHandler shareDataHandler] deleteCartoon:model];
        
        [self.dataArray removeObject:model];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    }
}



/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FunnyDetailViewController *funDetailVc = [[FunnyDetailViewController alloc] initWithNibName:@"FunnyDetailViewController" bundle:nil];
    
    funDetailVc.model = self.dataArray[indexPath.row];
    
    
    
    CollectionModel *model = self.dataArray[indexPath.row];
    
    NSLog(@"******%@", model.author);
    
    funDetailVc.albumId = @([model.albumId intValue]);
    [self.navigationController pushViewController:funDetailVc animated:YES];

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
