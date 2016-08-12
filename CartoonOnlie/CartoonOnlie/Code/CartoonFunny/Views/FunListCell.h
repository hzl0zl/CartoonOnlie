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
@property (strong, nonatomic) IBOutlet UILabel *updateSizeL;

@property (strong, nonatomic) IBOutlet UILabel *typeL;

@property (strong, nonatomic) IBOutlet UILabel *authorL;

@property (strong, nonatomic) IBOutlet UILabel *popularL;




@property (nonatomic, strong) FunListModel *listModel;

@end
