//
//  RadioCell.m
//  CartoonOnlie
//
//  Created by zhiling on 16/8/1.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "RadioCell.h"

@interface RadioCell ()

@property (strong, nonatomic) IBOutlet UIImageView *imageH;

@property (strong, nonatomic) IBOutlet UILabel *titleL;

@end

@implementation RadioCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
