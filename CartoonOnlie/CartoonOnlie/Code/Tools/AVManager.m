//
//  AVManager.m
//  iOS_PianKe
//
//  Created by zhiling on 16/7/26.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//
#import "AVManager.h"

@interface AVManager ()

//@property (nonatomic, assign) CMTime curTime;

@property (nonatomic, strong) AVPlayerItem *item;

//判断是否正在播放
@property (nonatomic, assign) BOOL isPlaying;

//播放下标
@property (nonatomic, assign) NSInteger playIndex;

@end

@implementation AVManager


//创建一个播放器的单例
+ (AVManager *)shareInstance {
   static AVManager *manage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manage = [[AVManager alloc] init];
   
    });

    return manage;
}
- (NSMutableArray *)musicUrls {
    
    if (_musicUrls == nil) {
        _musicUrls = [NSMutableArray array];
    }
    return _musicUrls;
}


//添加音乐的播放队列(文件)
- (void)setPlayList:(NSMutableArray *)playList flag:(NSInteger)number{
    
//    _musicUrls = playList;
    
    self.musicUrls = [playList copy];
    
    self.playIndex = number;
    
    NSString *urls = playList[number];
    
    NSURL *url = [NSURL URLWithString:urls];
    
    self.item = [[AVPlayerItem alloc] initWithURL:url];
    
    self.avPlay = [[AVPlayer alloc] initWithPlayerItem:self.item];
   
//      self.curTime = self.item.currentTime;

    
}


//上一首
- (void)aboveIndex:(NSInteger)index {
    
    self.playIndex--;
    if (self.playIndex == -1) {
        self.playIndex = self.musicUrls.count - 1;
        
    }
    NSURL *url = [NSURL URLWithString:self.musicUrls[self.playIndex]];
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];
    [self.avPlay replaceCurrentItemWithPlayerItem:item];
//    [self.avPlay play];
    
}

//下一首
- (void)nextIndex:(NSInteger)index {
    
    self.playIndex++;
    if (self.playIndex == self.musicUrls.count)
     {
         self.playIndex = 0;
        
    }
    NSURL *url = [NSURL URLWithString:self.musicUrls[self.playIndex]];
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];
    [self.avPlay replaceCurrentItemWithPlayerItem:item];
    
}

//播放/暂停
- (BOOL)play {
    
    if (self.isPlaying) {
        [self.avPlay pause];
        self.isPlaying = NO;
        return NO;
    }else {
        
        [self.avPlay play];
        self.isPlaying = YES;
        return YES;
    }
//    self.isPlaying = !self.isPlaying;
    
}

//改变音乐播放进度
- (void)playProgress:(float)progress {
    CMTime time = self.avPlay.currentItem.currentTime;
    time.value = self.avPlay.currentTime.timescale * progress;
    
    [self.avPlay seekToTime:time];
    self.isPlaying = 1;
    [self play];
    
    
}


////音乐文件的总时长
- (float)playDuration {
    if (self.avPlay.currentItem.duration.timescale == 0) {
        return 0;
    }
     float second = self.avPlay.currentItem.duration.value / self.avPlay.currentItem.duration.timescale;
    
    return second;
}
//当前时间
- (float)curuentTime {
    if (self.avPlay.currentItem.duration.timescale == 0) {
        return 0;
    }
  return  self.avPlay.currentItem.currentTime.value / self.avPlay.currentItem.currentTime.timescale;
    
}


- (float)duration {
    //获取当前总时间
    //判断当前播放状态
    NSInteger totaSec = 0;

    if (self.item.status == AVPlayerItemStatusReadyToPlay) {
        
        CMTime totalTime = self.item.duration;
        totaSec = totalTime.value / totalTime.timescale;
        
        CMTime curTime = self.item.currentTime;
         NSInteger sec = curTime.value / curTime.timescale;
        
        NSInteger h = sec / 3600;
        NSInteger m = (sec - (h * 3600)) / 60;
        NSInteger s = sec - h * 3600 - m * 60;
        
        h = totaSec / 3600;
        m = (totaSec - (h * 3600)) / 60;
        s = totaSec - h * 3600 - m * 60;
//        self.endTime.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",h, m, s];
       return  sec*1.0 / totaSec;
    }else {
        
//        self.endTime.text = @"00:00:00";
//        self.videoTime.value = 0.0;
        
        return 0.0;
    }

    
    
    
    
}


@end
