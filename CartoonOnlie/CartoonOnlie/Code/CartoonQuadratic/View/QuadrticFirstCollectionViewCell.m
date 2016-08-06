//
//  QuadrticFirstCollectionViewCell.m
//  CartoonOnlie
//
//  Created by lanou on 16/8/5.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "QuadrticFirstCollectionViewCell.h"
@interface QuadrticFirstCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *url;

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;

@end

@implementation QuadrticFirstCollectionViewCell


-(void)setModel:(QuadraticMainModel *)model
{
    _model = model ;
    
    NSURL *url = [NSURL URLWithString:model.vertical_image_url];
    [self.url  sd_setImageWithURL:url];
    self.labelTitle.text = model.title;
    
}



@end
