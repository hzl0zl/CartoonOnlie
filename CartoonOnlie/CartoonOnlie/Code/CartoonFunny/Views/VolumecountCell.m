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
        
        self.author = model.author;
        
        self.authorName = model.authorName;
        
        self.updateTime = model.updateTime;
        
        self.status = model.status;
        
        self.popular = model.popular;
        
        
        
        self.volumecountL.text = [NSString stringWithFormat:@"第 %@ 话", model.orderNumber];
        self.volumecountL.layer.cornerRadius = 18;
        self.volumecountL.layer.borderWidth = 0.1;
        self.volumecountL.layer.masksToBounds = YES;
        
    }
}




@end
