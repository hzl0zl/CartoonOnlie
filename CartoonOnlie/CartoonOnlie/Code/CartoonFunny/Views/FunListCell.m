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
        
        [self.titleImage sd_setImageWithURL:[NSURL URLWithString:listModel.url]];
        
        self.titleL.text = listModel.title;
        
        self.volemecountL.text = [NSString stringWithFormat:@"%@集", listModel.volumecount];
        
        
        self.middleL.text = @"/";
        
        if (listModel.updateflag) {
            self.updateflagL.text = @"连载中";
        }else
        {
            self.updateflagL.text = @"完结";
        }
        
        self.painterL.text = [NSString stringWithFormat:@"图: %@", listModel.painter];
        
        self.writerL.text = [NSString stringWithFormat:@"文: %@", listModel.writer];
        
        self.scoreL.text = [NSString stringWithFormat:@"评分: %@", listModel.score];
        
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
