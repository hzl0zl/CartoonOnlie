//
//  AudioPlayerController+methods.m
//  AudioPlayer
//
//  Created by ClaudeLi on 16/4/1.
//  Copyright © 2016年 ClaudeLi. All rights reserved.
//

#import "AudioPlayerController+methods.h"

@implementation AudioPlayerController (methods)

- (void)creatViews{
    self.rotatingView = [[RotatingView alloc] init];
    self.rotatingView.imageView.image = [UIImage imageNamed:@"音乐_播放器_默认唱片头像"];
    [self.view addSubview:self.rotatingView];
    
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    self.HUD.mode = MBProgressHUDModeText;
    self.HUD.userInteractionEnabled = NO;
    [self.view addSubview:self.HUD];
}

- (void)progressHUDWith:(NSString *)string{
    self.HUD.labelText = string;
    [self.HUD show:YES];
    [self.HUD hide:YES afterDelay:2.0f];
}

- (void)setRotatingViewFrame{
    CGFloat height_i4 = SCREEN_HEIGHT - topHeight - downHeight;
    if (SCREEN_HEIGHT < 500) {
        self.rotatingView.frame = CGRectMake(0, 0, height_i4*0.8, height_i4*0.8);
    }else{
        self.rotatingView.frame = CGRectMake(0, 0, SCREEN_WIDTH *0.8, SCREEN_WIDTH*0.8);
    }
    self.rotatingView.center = CGPointMake(SCREEN_WIDTH/2, height_i4/2 + topHeight);
    [self.rotatingView setRotatingViewLayoutWithFrame:self.rotatingView.frame];
}


- (void)setImageWith:(MusicModel *)model{
    /**
     *  添加旋转动画
     */
    [self.rotatingView addAnimation];
    
    self.underImageView.image = [UIImage imageNamed:@"音乐_播放器_默认模糊背景"];
    NSLog(@"%@", self.imageStr);
    [self.rotatingView.imageView sd_setImageWithURL:[NSURL URLWithString:self.imageStr] placeholderImage:[UIImage imageNamed:@"音乐_播放器_默认唱片头像"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            self.underImageView.image = [image applyDarkEffect];
        }
    }];
}
- (void)dealloc {
    
    NSLog(@"页面销毁");
}
@end
