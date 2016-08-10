//
//  QuadraticCellTableViewCell.m
//  CartoonOnlie
//
//  Created by lanou on 16/8/8.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "QuadraticCellTableViewCell.h"

@interface QuadraticCellTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *image_url;

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *time;

@end

@implementation QuadraticCellTableViewCell


-(void)setModel:(QuadriticCellModel *)model
{
    _model = model;
    
    self.title.text = model.title;
    
    NSURL *url = [NSURL URLWithString:model.cover_image_url];
    [self.image_url sd_setImageWithURL:url];
    
    //NSnumber转 NSdate
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:[model.created_at doubleValue]];
    //创建格式
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init]; 
    [dateFormatter setDateFormat:@"MM月dd日 HH:mm"];
    //转字符串
    NSString *time  = [dateFormatter stringFromDate:date];

    self.time.text = time;

    
    
}


@end
