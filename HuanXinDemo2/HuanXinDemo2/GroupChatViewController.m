//
//  GroupChatViewController.m
//  HuanXinDemo2
//
//  Created by 余婷 on 2016/12/14.
//  Copyright © 2016年 余婷. All rights reserved.
//

#import "GroupChatViewController.h"

@interface GroupChatViewController ()

@end

@implementation GroupChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - UI相关  
- (void)navigationBarSetting{

    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editGroupAction)];
}

- (void)editGroupAction{

    
}

@end
