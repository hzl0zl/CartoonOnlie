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

- (void)setFrame:(CGRect)frame {
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 10;
    frame.size.width = width;
    
//    CGFloat height = [UIScreen mainScreen].bounds.size.height - 10;
//    frame.size.height = height;
    
    CGFloat x = 5;
    frame.origin.x = x;
    
    
    [super setFrame:frame];
    
//    CGFloat y = 90;
//    frame.origin.y = y;
    
   
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
