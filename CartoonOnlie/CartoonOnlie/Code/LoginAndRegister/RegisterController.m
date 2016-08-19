//
//  RegisterController.m
//  CartoonOnlie
//
//  Created by zhiling on 16/8/5.
//  Copyright © 2016年 huangzhiling. All rights reserved.
//

#import "RegisterController.h"
#import "NSString+Md5String.h"
@interface RegisterController ()

@property (strong, nonatomic) IBOutlet UITextField *usernameText;

@property (strong, nonatomic) IBOutlet UITextField *phoneText;

@property (strong, nonatomic) IBOutlet UITextField *passText;
@property (strong, nonatomic) IBOutlet UITextField *again;

@end

@implementation RegisterController
- (IBAction)regsitAction:(id)sender {
    
    NSString *Url = @"http://api.idothing.com/zhongzi/v2.php/User/registerWithTel";
    
    
    NSString *body1 = [NSString stringWithFormat:@"account=%@&avatar=ni&gender=1&nickname=%@&password=%@",self.phoneText.text,self.usernameText.text,[self.passText.text md532BitUpper]];
    
    [DownLoad dowmLoadWithUrl:Url postBody:body1 resultBlock:^(NSData *data) {
        
         NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dict[@"info"]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            if ([dict[@"info"] isEqualToString:@"用户注册成功"]) {
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"通知" message:@"恭喜你注册成功!!!" preferredStyle:UIAlertControllerStyleAlert];
                
                [ alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    [self dismissViewControllerAnimated:YES completion:nil];
                    
                } ]];
                
                [self presentViewController:alert animated:true completion:nil];
                
                
            }
            
        });
   
      
     
    }];
    
    
    
    
    
}

- (IBAction)backAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
