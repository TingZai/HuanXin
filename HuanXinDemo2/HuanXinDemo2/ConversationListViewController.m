//
//  ConversationListViewController.m
//  HuanXinDemo2
//
//  Created by 余婷 on 2016/12/13.
//  Copyright © 2016年 余婷. All rights reserved.
//

#import "ConversationListViewController.h"

@interface ConversationListViewController ()<EaseConversationListViewControllerDataSource,EMChatManagerDelegate,EaseConversationListViewControllerDelegate>

@end

@implementation ConversationListViewController

- (void)loadView{

    [super loadView];
    self.dataSource = self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    self.title = @"消息";
    
    //注册消息回调
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    
    //设置会话列表cell的样式
    //设置时间label的字体和颜色
    [[EaseConversationCell appearance] setTimeLabelFont:[UIFont systemFontOfSize:11]];
    [[EaseConversationCell appearance] setTimeLabelColor:[UIColor colorWithRed:245/255.0f green:166/255.0f blue:35/255.0f alpha:1]];
    [[EaseConversationCell appearance] setTitleLabelColor:[UIColor colorWithRed:79/255.0f green:139/255.0f blue:14/255.0f alpha:1]];
    [[EaseConversationCell appearance] setDetailLabelColor:[UIColor colorWithRed:211/255.0 green:104/255.0 blue:75/255.0 alpha:1]];
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self refreshAndSortView];
}

#pragma mark - 消息回调
- (void)messagesDidReceive:(NSArray *)aMessages{
    
    [self refreshAndSortView];
}

#pragma mark - 自定义时间样式
- (NSString *)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
       latestMessageTimeForConversationModel:(id<IConversationModel>)conversationModel{

    NSString * lastMessageTime = @"";
    
    EMMessage * lastMessage = [conversationModel.conversation latestMessage];
    NSDate * lasetDate = [NSDate dateWithTimeIntervalSince1970:lastMessage.timestamp];
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"hh:mm:ss";
    
    lastMessageTime = [formatter stringFromDate:lasetDate];
    
    return lastMessageTime;
}

- (id<IConversationModel>)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
                                    modelForConversation:(EMConversation *)conversation{
    
    EaseConversationModel * model = [[EaseConversationModel alloc] initWithConversation:conversation];
    
    //在这儿获取头像和昵称登信息
//    model.title = @"昵称";
    model.avatarImage = [UIImage imageNamed:@"avatarImage_A"];
    
    
    return model;

}



@end
