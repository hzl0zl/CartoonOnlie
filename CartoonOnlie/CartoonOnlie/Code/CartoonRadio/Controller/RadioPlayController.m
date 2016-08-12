//
//  RadioPlayController.m
//  iOS_PianKe
//
//  Created by zhiling on 16/7/26.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "RadioPlayController.h"
#import "RadioDetaiModel.h"
#import "AVManager.h"
#import "SDAutoLayout.h"
@interface RadioPlayController ()

@property (strong, nonatomic) IBOutlet UIImageView *imageV;
@property (strong, nonatomic) IBOutlet UIImageView *cdView;

@property (strong, nonatomic) IBOutlet UILabel *timeL;
@property (strong, nonatomic) IBOutlet UISlider *slider;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong, nonatomic) IBOutlet UIButton *playBtn;
@property (nonatomic, strong)CADisplayLink *singerTimer;

@property (strong, nonatomic) IBOutlet UIImageView *revolveView;


@property (nonatomic, strong) AVManager *av;



@end

//static NSInteger index1;

@implementation RadioPlayController

#pragma mark ===下载


#pragma mark ===改变播放位置
- (IBAction)changePlayLocation:(id)sender {
    
    
    [self.av playProgress:self.slider.value];
    
    [self.av play];
    
}
#pragma mark ===上一首
- (IBAction)above:(id)sender {
    
    self.number --;
    if (self.number == -1) {
        self.number = self.musics.count - 1;
    }
    
//    NSURL *url = [NSURL URLWithString:[self.musics[self.number] coverimg]];
    
//    [self.imageV sd_setImageWithURL:url];
    
    [self.av aboveIndex:0];
    
    
}
#pragma mark ===下一首
- (IBAction)next:(id)sender {

    self.number ++;
    if (self.number == self.musics.count) {
        self.number = 0;
    }
    
//    NSURL *url = [NSURL URLWithString:[self.musics[self.number] coverimg]];
    
//    [self.imageV sd_setImageWithURL:url];
    
    [self.av nextIndex:0];
    
    
    
}
#pragma mark ===暂停或者播放
- (IBAction)play:(id)sender {
    

    if ([self.av play]) {
        
   
          self.singerTimer.paused = NO;
        
    } else {
        
          self.singerTimer.paused = YES;
    }
     self.playBtn.selected = !self.playBtn.selected;
    
//   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    self.cdView.sd_layout.leftSpaceToView(self.view, 60).topSpaceToView(self.view,80).heightIs(200).widthRatioToView(self.view, 0.4);
//    
    self.revolveView.layer.cornerRadius = self.revolveView.frame.size.width / 2;
    self.revolveView.layer.masksToBounds = YES;
    self.slider.value = 0;
//    self.hidesBottomBarWhenPushed = YES;
    self.av = [AVManager shareInstance];
    
    NSMutableArray *arr = [NSMutableArray array];
    
    for (RadioDetaiModel *detail in self.musics) {
        
        [arr addObject:detail.url];
    }
    
    NSLog(@"******%ld", self.number);
    [self.av setPlayList:arr flag:self.number];
    
    
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    
}

#pragma mark ===定时器中执行方法
- (void)updateTime {
    
    
    float sec = [self.av playDuration];
    NSInteger a = sec / 60;
    NSInteger b = (int)sec % 60;
    
    
    float totaTime = [self.av curuentTime];
//    NSLog(@"%f", totaTime);
    NSInteger a1 = totaTime / 60;
    NSInteger b1 = (int)totaTime % 60;
    
    
    self.timeL.text = [NSString stringWithFormat:@"%02ld:%02ld",a, b];
    self.timeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld",a1, b1];
    
    //改变进度条的进度
    self.slider.maximumValue = self.av.playDuration;
    self.slider.value = self.av.curuentTime;
    
}


- (CADisplayLink *)singerTimer
{
    if (_singerTimer == nil)
    {
        _singerTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(setImageRoutation)];
        
        [_singerTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    
    return _singerTimer;
}

//按照屏幕刷新率来调用 每秒调用 60次
- (void)setImageRoutation
{
    self.revolveView.transform = CGAffineTransformRotate(self.revolveView.transform, M_PI * 2 / 60 / 7);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
