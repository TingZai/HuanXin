//
//  ConversationListViewController.m
//  HuanXinDemo2
//
//  Created by 余婷 on 2016/12/13.
//  Copyright © 2016年 余婷. All rights reserved.
//

#import "ConversationListViewController.h"

@interface ConversationListViewController ()<EaseConversationListViewControllerDataSource,EMChatManagerDelegate>

@end

@implementation ConversationListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = self;
    self.title = @"消息";
    
    //注册消息回调
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    
//    [self showRefreshHeader];
//    [self showRefreshFooter];
    
}

#pragma mark - 消息回调
- (void)messagesDidReceive:(NSArray *)aMessages{
    
    [self refreshAndSortView];
}

- (void)messagesDidRead:(NSArray *)aMessages{

    NSLog(@"消息已读");
}


#pragma mark - 自定义时间样式
- (NSString *)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
       latestMessageTimeForConversationModel:(id<IConversationModel>)conversationModel{

    NSString * lastMessageTime = @"123";
    EMMessage * lastMessage = [conversationModel.conversation latestMessage];
    NSDate * lasetDate = [NSDate dateWithTimeIntervalSince1970:lastMessage.timestamp];
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"hh:mm:ss";
    
    lastMessageTime = [formatter stringFromDate:lasetDate];
    
    return lastMessageTime;
}

@end
