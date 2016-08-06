//
//  QuadraticTwoCollectionViewCell.m
//  CartoonOnlie
//
//  Created by lanou on 16/8/5.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "QuadraticTwoCollectionViewCell.h"
@interface QuadraticTwoCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *urls;

@end

@implementation QuadraticTwoCollectionViewCell


-(void)setModel:(QuadraticMainModel *)model
{
    _model = model ;
    
    NSURL *url = [NSURL URLWithString:model.vertical_image_url];
    [self.urls  sd_setImageWithURL:url];
    
    }


@end
