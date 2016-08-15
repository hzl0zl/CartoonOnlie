//
//  RadioDetailCell.m
//  CartoonOnlie
//
//  Created by zhiling on 16/8/3.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "RadioDetailCell.h"
#import "MusicModel.h"
@interface RadioDetailCell ()

//@property (strong, nonatomic) IBOutlet UIImageView *imageH;

@property (strong, nonatomic) IBOutlet UILabel *titleL;

@property (strong, nonatomic) IBOutlet UILabel *timeL;
@end

@implementation RadioDetailCell

- (void)setRadioDetailModel:(MusicModel *)radioDetailModel {
    
    _radioDetailModel = radioDetailModel;
    
    self.titleL.text = radioDetailModel.sub_title;
//    self.imageH.layer.cornerRadius = 20;
//    self.imageH.layer.masksToBounds = YES;
//    [self.imageH sd_setImageWithURL:[NSURL URLWithString:self.imageStr]];
    self.timeL.text = radioDetailModel.stream_time;
    
//    [self.imageH sd_setImageWithURL:[NSURL URLWithString:dict[@"small"]]];
//    if (self.imageH.image == nil) {
//        self.imageH.image = [UIImage imageNamed:@"bgm"];
//    }
//    

    
}





- (void)awakeFromNib {
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
