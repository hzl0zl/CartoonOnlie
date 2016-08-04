//
//  TerrofyingCell.m
//  CartoonOnlie
//
//  Created by zhiling on 16/7/30.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "TerrofyingCell.h"


@interface TerrofyingCell ()


@property (strong, nonatomic) IBOutlet UIImageView *imageH;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UILabel *descLabel;

@end

@implementation TerrofyingCell

- (void)setTerrModel:(TerrofyingModel *)terrModel {
    
    _terrModel = terrModel;
    
    [self.imageH sd_setImageWithURL:[NSURL URLWithString:terrModel.cover]];
    self.titleLabel.text = terrModel.name;
    self.descLabel.text = terrModel.shotdesc;
    
    
    
    
}
- (void)awakeFromNib {
    // Initialization code
}

@end
