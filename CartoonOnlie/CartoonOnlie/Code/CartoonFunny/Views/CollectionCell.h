//
//  CollectionCell.h
//  CartoonOnlie
//
//  Created by lanou on 16/8/6.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionModel.h"


@interface CollectionCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *titleImage;

@property (strong, nonatomic) IBOutlet UILabel *titleL;
@property (strong, nonatomic) IBOutlet UILabel *descL;
@property (nonatomic, strong) NSString *albumId;

@property (nonatomic, strong) CollectionModel *model;

@property (nonatomic, strong) NSString *author;

@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) NSNumber *updateSize;

@property (nonatomic, strong) NSNumber *popular;


@end
