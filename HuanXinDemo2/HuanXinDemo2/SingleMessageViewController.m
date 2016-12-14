//
//  SingleMessageViewController.m
//  HuanXinDemo2
//
//  Created by 余婷 on 2016/12/13.
//  Copyright © 2016年 余婷. All rights reserved.
//

#import "SingleMessageViewController.h"
#import "FriendInfoViewController.h"

@interface SingleMessageViewController ()<EMChatManagerDelegate,EaseMessageViewControllerDelegate,EaseMessageViewControllerDataSource>

@end

@implementation SingleMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    self.delegate = self;
    self.dataSource = self;
    
    //设置聊天气泡的样式
    [[EaseBaseMessageCell appearance] setSendBubbleBackgroundImage:[UIImage imageNamed:@"chat_sender_bg"]];
    [[EaseBaseMessageCell appearance] setRecvBubbleBackgroundImage:[UIImage imageNamed:@"chat_receiver_bg"]];
    
    //设置头像大小
    [[EaseBaseMessageCell appearance] setAvatarSize:40.f];
    //设置头像圆角大小
    [[EaseBaseMessageCell appearance] setAvatarCornerRadius:20.0f];
    
    //设置昵称颜色
    [[EaseBaseMessageCell appearance] setMessageNameColor:[UIColor colorWithRed:79/255.0f green:139/255.0f blue:14/255.0f alpha:1]];
    
    //设置消息颜色
    [[EaseMessageCell appearance] setMessageTextColor:[UIColor whiteColor]];
    
}

- (void)messageViewController:(EaseMessageViewController *)viewController didSelectAvatarMessageModel:(id<IMessageModel>)messageModel{

    FriendInfoViewController * friendV = [[FriendInfoViewController alloc] init];
    friendV.hidesBottomBarWhenPushed = YES;
    friendV.userName = messageModel.message.from;
    [self.navigationController pushViewController:friendV animated:true];
}


//设置用户昵称和头像
- (id<IMessageModel>)messageViewController:(EaseMessageViewController *)viewController modelForMessage:(EMMessage *)message{

    id<IMessageModel> model = nil;
    
    model = [[EaseMessageModel alloc] initWithMessage:message];
    //设置默认头像
    model.avatarImage = [UIImage imageNamed:@"avatarImage"];
    //设置头像URL
    model.avatarURLPath = @"";
    //设置昵称
    model.nickname = message.from;
    
    return model;
}



@end
