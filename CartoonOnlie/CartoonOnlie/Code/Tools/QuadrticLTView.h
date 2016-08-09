//
//  QuadrticLTView.h
//  CartoonOnlie
//
//  Created by lanou on 16/8/8.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuadrticLTView : UIView

@property (nonatomic,strong) UILabel *title;

@property (nonatomic,strong) UILabel *author;

@property (nonatomic,strong) UILabel *type;

-(instancetype)initQuadrticLTViewWith:(CGRect)frame headerAndFoote:(NSString *)type;

@end
