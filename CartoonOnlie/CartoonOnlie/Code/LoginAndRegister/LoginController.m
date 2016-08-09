//
//  LoginController.m
//  CartoonOnlie
//
//  Created by zhiling on 16/8/5.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "LoginController.h"
#import "RegisterController.h"
#import "NSString+Md5String.h"
#import "UMSocial.h"
#import "UMSocialSinaSSOHandler.h"

@interface LoginController ()

@property (strong, nonatomic) IBOutlet UIButton *loginBtn;

@property (strong, nonatomic) IBOutlet UIButton *qqLogin;

@property (strong, nonatomic) IBOutlet UIButton *sinaLogin;

@property (strong, nonatomic) IBOutlet UIButton *registerBtn;

@property (strong, nonatomic) IBOutlet UITextField *emailText;

@property (strong, nonatomic) IBOutlet UITextField *passwordText;

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


    NSString *Url = @"http://api.idothing.com/zhongzi/v2.php/User/login";
    
    NSString *body = [NSString stringWithFormat:@"account=%@&account_type=4&password=%@",self.emailText.text,[self.passwordText.text md532BitUpper]];
    
    [DownLoad dowmLoadWithUrl:Url postBody:body resultBlock:^(NSData *data) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@", dict);
//        NSLog(@"%@", dict[@"results"][@"status"]);
        NSLog(@"%@", dict[@"info"]);
       dispatch_async(dispatch_get_main_queue(), ^{
          
           if ([dict[@"info"] isEqualToString:@"登陆成功"]) {
               
               NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
               
               [user setValue:self.emailText.text forKey:@"userName"];
               [user setValue:self.passwordText.text forKey:@"passWork"];

               UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"通知" message:@"恭喜您登陆成功!!!" preferredStyle:UIAlertControllerStyleAlert];
               
               [ alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                   
                   [self dismissViewControllerAnimated:YES completion:nil];
                   
                   
               } ]];
               
               [self presentViewController:alert animated:true completion:nil];
               
           }else {
               
               UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:dict[@"info"] preferredStyle:UIAlertControllerStyleAlert];
               
               [ alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                   
//                   [self dismissViewControllerAnimated:YES completion:nil];
                   
                   
               } ]];
               
           }
      
           
       });
        
        
        
        
    }];
    
    
    
    
}
#pragma mark ==== 新浪登陆
- (IBAction)wbAction:(id)sender {
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            NSDictionary *dict = [UMSocialAccountManager socialAccountDictionary];
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsPlatform.platformName];
            NSLog(@"\nusername = %@,\n usid = %@,\n token = %@ iconUrl = %@,\n unionId = %@,\n thirdPlatformUserProfile = %@,\n thirdPlatformResponse = %@ \n, message = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId, response.thirdPlatformUserProfile, response.thirdPlatformResponse, response.message);
            [self dismissViewControllerAnimated:YES completion:nil];
            
            NSLog(@"%@", dict);
            
        }});
  
    
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
    
    self.registerBtn.layer.cornerRadius = 5;
    self.registerBtn.layer.masksToBounds = YES;
    self.registerBtn.layer.borderWidth = 1;
    self.registerBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    
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
