//
//  FriendInfoViewController.m
//  HuanXinDemo2
//
//  Created by 余婷 on 2016/12/13.
//  Copyright © 2016年 余婷. All rights reserved.
//

#import "FriendInfoViewController.h"
#import "EMSDK.h"

@interface FriendInfoViewController ()

@end

@implementation FriendInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)deleteFriend:(id)sender {
    
   EMError * error = [[EMClient sharedClient].contactManager deleteContact:self.userName isDeleteConversation:YES];
    
    if (!error) {
        
        NSLog(@"删除成功");
    }
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
