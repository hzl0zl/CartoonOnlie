//
//  FunListCell.m
//  CartoonOnlie
//
//  Created by lanou on 16/7/30.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "FunListCell.h"
#import "UIImageView+WebCache.h"

@implementation FunListCell


- (void)setListModel:(FunListModel *)listModel
{
    if (_listModel != listModel) {
        _listModel = listModel;
        
        NSURL *url = [NSURL URLWithString:listModel.coverPic];
        
    
        [self.titleImage sd_setImageWithURL:url];
        
        self.titleL.text = listModel.name;
        
        self.authorL.text = [NSString stringWithFormat:@"作者: %@", listModel.author];
        
        self.typeL.text = [NSString stringWithFormat:@"类型: %@", listModel.label];
        
        self.updateSizeL.text = [NSString stringWithFormat:@"更新至%@话", listModel.updateSize]; 
        
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
