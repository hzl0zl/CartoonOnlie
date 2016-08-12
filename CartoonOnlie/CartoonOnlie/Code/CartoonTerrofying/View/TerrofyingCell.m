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
    
    //NSnumber转 NSdate
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:[terrModel.updatetime doubleValue]];
    //创建格式
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MM月dd日 HH:mm"];
    //转字符串
    NSString *time  = [dateFormatter stringFromDate:date];
    
//    self.time.text = time;
    
    self.titleL.text = time;
    
}

- (void)awakeFromNib {
    // Initialization code
}

@end
