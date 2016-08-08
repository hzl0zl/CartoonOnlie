//
//  QuadraticTableViewCell.m
//  CartoonOnlie
//
//  Created by lanou on 16/8/4.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "QuadraticTableViewCell.h"

@interface QuadraticTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *url;


@end

@implementation QuadraticTableViewCell

-(void)setModel:(QuadraticModel *)model
{
    _model = model;
    
    NSURL *urls = [NSURL URLWithString:model.cover_image_url];
    
    [self.url sd_setImageWithURL:urls];

    
}

@end
