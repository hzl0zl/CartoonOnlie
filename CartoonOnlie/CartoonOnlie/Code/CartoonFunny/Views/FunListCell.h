//
//  FunListCell.h
//  CartoonOnlie
//
//  Created by lanou on 16/7/30.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FunListModel.h"

@interface FunListCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *titleImage;
@property (strong, nonatomic) IBOutlet UILabel *titleL;
@property (strong, nonatomic) IBOutlet UILabel *volemecountL;
@property (strong, nonatomic) IBOutlet UILabel *middleL;
@property (strong, nonatomic) IBOutlet UILabel *updateflagL;

@property (strong, nonatomic) IBOutlet UILabel *painterL;
@property (strong, nonatomic) IBOutlet UILabel *writerL;
@property (strong, nonatomic) IBOutlet UIImageView *scoreImage;
@property (strong, nonatomic) IBOutlet UILabel *scoreL;

@property (nonatomic, strong) FunListModel *listModel;

@end
