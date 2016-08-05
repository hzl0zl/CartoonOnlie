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
@property (strong, nonatomic) IBOutlet UILabel *titleL;

@end

@implementation TerrofyingCell

- (void)setTerrModel:(TerrListModel *)terrModel {
    
    
    _terrModel = terrModel;
    
    [self.imageH sd_setImageWithURL:[NSURL URLWithString:terrModel.pcover]];
    self.titleLabel.text = terrModel.title;
    self.descLabel.text = [NSString stringWithFormat:@"%@", terrModel.dig];
    self.titleL.text = [NSString stringWithFormat:@"%@", terrModel.updatetime];
    
}

- (void)awakeFromNib {
    // Initialization code
}

@end
