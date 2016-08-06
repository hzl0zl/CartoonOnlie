//
//  VolumecountCell.h
//  CartoonOnlie
//
//  Created by lanou on 16/8/4.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FunnyDetailModel.h"

@interface VolumecountCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *volumecountL;

//@property (nonatomic, strong) NSString *url;


@property (nonatomic, strong) FunnyDetailModel *model;

@end
