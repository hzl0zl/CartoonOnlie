//
//  AVManager.h
//  iOS_PianKe
//
//  Created by zhiling on 16/7/26.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//
//@class AVPlayer;
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface AVManager : NSObject


@property (nonatomic, strong) AVPlayer *avPlay;

@property (nonatomic, strong) NSMutableArray *musicUrls;

//创建一个播放器的单例
+ (AVManager *)shareInstance;

//上一首
- (void)aboveIndex:(NSInteger)index;

//下一首
- (void)nextIndex:(NSInteger)index;

//播放/暂停
- (BOOL)play;

//改变音乐播放进度
- (void)playProgress:(float)progress;

//添加音乐的播放队列(文件)
- (void)setPlayList:(NSMutableArray *)playList flag:(NSInteger)number;

//音乐文件的总时长
- (float)playDuration;

//当前时长
- (float)curuentTime;

- (float)duration;

//- (void)setCurTime:(float)time;

@end
