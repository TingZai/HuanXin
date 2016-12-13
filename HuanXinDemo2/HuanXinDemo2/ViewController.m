//
//  ViewController.m
//  HuanXinDemo2
//
//  Created by 余婷 on 2016/12/12.
//  Copyright © 2016年 余婷. All rights reserved.
//

#import "ViewController.h"
#import "EMSDK.h"
#import "UserInfoViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

//登录
- (IBAction)loginAction:(id)sender {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [[EMClient sharedClient] loginWithUsername:_userName.text password:_passWord.text completion:^(NSString *aUsername, EMError *aError) {
            
            NSLog(@"%@",aUsername);
            NSLog(@"%@",aError);
            NSLog(@"%@",[NSThread currentThread]);
            if (aUsername) {
                
                UserInfoViewController * userInfo = [[UserInfoViewController alloc] init];
                userInfo.userName = aUsername;
                [self.navigationController pushViewController:userInfo animated:YES];
            }
            
        }];
    });
    
    
    
}




@end
