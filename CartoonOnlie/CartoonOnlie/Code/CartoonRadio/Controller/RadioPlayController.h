//
//  RadioPlayController.h
//  iOS_PianKe
//
//  Created by zhiling on 16/7/26.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailRadio;

@interface RadioPlayController : UIViewController

@property (nonatomic, assign) NSInteger number;

//用一个数组存放音频文件
@property (nonatomic, strong) NSMutableArray *musics;

@end
