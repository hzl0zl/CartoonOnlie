//
//  QuadrticFirstCollectionViewCell.h
//  CartoonOnlie
//
//  Created by lanou on 16/8/5.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuadraticMainModel.h"
@interface QuadrticFirstCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) QuadraticMainModel *model;
@property (strong, nonatomic) IBOutlet UILabel *numberL;

@end
