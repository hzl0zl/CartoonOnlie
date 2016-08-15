//
//  RadioDetailCell.h
//  CartoonOnlie
//
//  Created by zhiling on 16/8/3.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import <UIKit/UIKit.h>


@class MusicModel;
@interface RadioDetailCell : UITableViewCell

@property (nonatomic, strong) MusicModel *radioDetailModel;

@property (nonatomic, strong) NSString *imageStr;

@end
