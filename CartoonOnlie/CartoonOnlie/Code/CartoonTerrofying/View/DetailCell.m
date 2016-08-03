//
//  DetailCell.m
//  CartoonOnlie
//
//  Created by zhiling on 16/8/1.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "DetailCell.h"
#import "UIImageView+WebCache.h"

@interface DetailCell ()

@property (strong, nonatomic) IBOutlet UIImageView *imageH;

@property (strong, nonatomic) IBOutlet UILabel *titleL;

@property (strong, nonatomic) IBOutlet UILabel *descL;

@end

@implementation DetailCell


- (void)setTerrModel:(TerrofyingModel *)terrModel {
    
    _terrModel = terrModel;
    
    [self.imageH sd_setImageWithURL:[NSURL URLWithString:terrModel.cover]];
    self.titleL.text = terrModel.name;
    self.descL.text = terrModel.shotdesc;
    
    
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
