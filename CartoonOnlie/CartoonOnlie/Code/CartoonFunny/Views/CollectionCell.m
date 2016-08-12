//
//  CollectionCell.m
//  CartoonOnlie
//
//  Created by lanou on 16/8/6.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "CollectionCell.h"

@implementation CollectionCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(CollectionModel *)model
{
    if (_model != model) {
        
        _model = model;
        
        NSURL *url = [NSURL URLWithString:model.coverPic];
        
        [self.titleImage sd_setImageWithURL:url];
        
        self.titleL.text = model.name;
        
        self.descL.text = model.descriptions;
            
        self.author = model.author;
    
        self.type = model.label;
        
        self.updateSize = model.updateSize;
        
        self.popular = model.popular;
        
        }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
