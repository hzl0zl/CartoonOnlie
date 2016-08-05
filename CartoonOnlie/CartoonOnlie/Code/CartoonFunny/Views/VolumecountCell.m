//
//  VolumecountCell.m
//  CartoonOnlie
//
//  Created by lanou on 16/8/4.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "VolumecountCell.h"

@implementation VolumecountCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(FunnyDetailModel *)model
{
    if (_model != model) {
        _model = model;
        self.volumecountL.text = [NSString stringWithFormat:@"第 %@ 话", model.orderNumber];
    }
}

@end
