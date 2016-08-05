//
//  RadioCell.m
//  CartoonOnlie
//
//  Created by zhiling on 16/8/1.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "RadioCell.h"
@interface RadioCell ()

@property (strong, nonatomic) IBOutlet UIImageView *imageH;

@property (strong, nonatomic) IBOutlet UILabel *titleL;

@end

@implementation RadioCell


- (void)setRadioModel:(RadioModel *)radioModel {
    
    _radioModel = radioModel;
    
    self.titleL.text = radioModel.wiki_title;
    
    NSDictionary *dict = radioModel.wiki_cover;
//    NSLog(@"%@", dict);
    self.imageH.layer.cornerRadius = 20;
    self.imageH.layer.masksToBounds = YES;
 
    [self.imageH sd_setImageWithURL:[NSURL URLWithString:dict[@"small"]]];
    if (self.imageH.image == nil) {
           self.imageH.image = [UIImage imageNamed:@"bgm"];
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
