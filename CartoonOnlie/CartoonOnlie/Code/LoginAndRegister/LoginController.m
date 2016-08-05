//
//  LoginController.m
//  CartoonOnlie
//
//  Created by zhiling on 16/8/5.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "LoginController.h"
#import "RegisterController.h"
@interface LoginController ()

@property (strong, nonatomic) IBOutlet UIButton *loginBtn;

@property (strong, nonatomic) IBOutlet UIButton *qqLogin;

@property (strong, nonatomic) IBOutlet UIButton *sinaLogin;
@end


@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self editBtn];
    
    
}
#pragma mark ==== 注册
- (IBAction)registerAction:(id)sender {
    
    RegisterController *registerVC = [[RegisterController alloc] init];
    
    [self presentViewController:registerVC animated:YES completion:nil];

    
}
#pragma mark ==== 登陆
- (IBAction)loginAction:(id)sender {
}

#pragma mark ==== 忘记密码
- (IBAction)forgetAction:(id)sender {
}


#pragma mark === 返回
- (IBAction)backAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}















- (void)editBtn {
    
    
    self.loginBtn.layer.cornerRadius = 5;
    self.loginBtn.layer.masksToBounds = YES;
    self.loginBtn.layer.borderWidth = 1;
    self.loginBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.qqLogin.layer.cornerRadius = 5;
    self.qqLogin.layer.masksToBounds = YES;
    self.qqLogin.layer.borderWidth = 1;
    self.qqLogin.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.sinaLogin.layer.cornerRadius = 5;
    self.sinaLogin.layer.masksToBounds = YES;
    self.sinaLogin.layer.borderWidth = 1;
    self.sinaLogin.layer.borderColor = [UIColor whiteColor].CGColor;
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
