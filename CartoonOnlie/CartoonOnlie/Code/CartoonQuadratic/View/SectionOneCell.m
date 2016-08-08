//
//  SectionOneCell.m
//  CartoonOnlie
//
//  Created by zhiling on 16/8/8.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "SectionOneCell.h"

@interface SectionOneCell ()

@property (strong, nonatomic) IBOutlet UIImageView *url;


@property (strong, nonatomic) IBOutlet UILabel *labelTitle;


@end

@implementation SectionOneCell



-(void)setModel:(QuadraticMainModel *)model
{
    _model = model ;
    
    NSURL *url = [NSURL URLWithString:model.vertical_image_url];
    [self.url  sd_setImageWithURL:url];
    self.labelTitle.text = model.title;
    
}


- (void)awakeFromNib {
    // Initialization code
}

@end
