//
//  GroupChatViewController.m
//  HuanXinDemo2
//
//  Created by 余婷 on 2016/12/14.
//  Copyright © 2016年 余婷. All rights reserved.
//

#import "GroupChatViewController.h"
#import "GroupSettingViewController.h"

@interface GroupChatViewController ()

@end

@implementation GroupChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self navigationBarSetting];
}

#pragma mark - UI相关  
- (void)navigationBarSetting{

    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editGroupAction)];
    
    self.navigationItem.rightBarButtonItem = item;
}

- (void)editGroupAction{

    GroupSettingViewController * setting = [GroupSettingViewController new];
    setting.currentGroup = self.currentGroup;
    setting.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:setting animated:YES];
}

@end
