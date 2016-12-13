//
//  UserInfoViewController.m
//  HuanXinDemo2
//
//  Created by 余婷 on 2016/12/12.
//  Copyright © 2016年 余婷. All rights reserved.
////会话对象


#import "UserInfoViewController.h"
#import "EMSDK.h"
#import "ConversationInfoViewController.h"

@interface UserInfoViewController ()

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self navigationBarSetting];
    
    [self getConversation];
}

//设置导航条
- (void)navigationBarSetting{

    //添加添加按钮
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction)];
    self.navigationItem.rightBarButtonItem = item;
    
}

//添加会话
- (void)addAction{

   EMConversation * conversation = [[EMClient sharedClient].chatManager getConversation:@"xiaogou" type:EMConversationTypeChat createIfNotExist:YES];
    
    NSLog(@"%@",conversation);
    ConversationInfoViewController * conver = [[ConversationInfoViewController alloc] init];
    conver.conversaction = conversation;
    [self.navigationController pushViewController:conver animated:YES];
}


//获取所有的会话列表
- (void)getConversation{

   NSArray * allConversations = [[EMClient sharedClient].chatManager getAllConversations];
    
    NSLog(@"%@",allConversations);
}


@end
