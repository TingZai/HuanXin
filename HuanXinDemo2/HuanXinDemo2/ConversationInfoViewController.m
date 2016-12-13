//
//  ConversationInfoViewController.m
//  HuanXinDemo2
//
//  Created by 余婷 on 2016/12/12.
//  Copyright © 2016年 余婷. All rights reserved.
//

#import "ConversationInfoViewController.h"

@interface ConversationInfoViewController ()<EMChatManagerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *messageField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation ConversationInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册消息回调
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:dispatch_get_global_queue(0, 0)];
    
    
    //获取指定时间段内的所有消息
    NSDate * currentdate = [NSDate date];
    NSDate * beforDate = [NSDate dateWithTimeIntervalSinceNow:-24*60*60];
    [self getMessageFrom:beforDate to:currentdate];
    
}

#pragma mark - 消息界面搭建 
- (void)creatUI{

    
}

#pragma mark - 获取指定时间段内的消息  
- (void)getMessageFrom:(NSDate*)date1 to:(NSDate*)date2{

    //将时间转换成时间戳
    NSTimeInterval  time1 = [date1 timeIntervalSince1970];
    NSTimeInterval  time2 = [date2 timeIntervalSince1970];
    
    [self.conversaction loadMessagesFrom:time1 to:time2 count:10 completion:^(NSArray *aMessages, EMError *aError) {
       
         NSLog(@"获取所有消息:%@",aMessages);
    }];
}

#pragma mark - 发送消息
- (IBAction)sendAction:(id)sender {
    //要发送的消息
    EMTextMessageBody * body = [[EMTextMessageBody alloc] initWithText:_messageField.text];
    //当前账号
    NSString * form = [[EMClient sharedClient] currentUsername];
    
    EMMessage * message;
    if ([form isEqualToString:@"yuting"]) {
        
        message = [[EMMessage alloc] initWithConversationID:self.conversaction.conversationId from:form to:@"xiaogou" body:body ext:nil];
    }else{
    
        message = [[EMMessage alloc] initWithConversationID:self.conversaction.conversationId from:form to:@"yuting" body:body ext:nil];
    
    }
    
    message.chatType = EMChatTypeChat;
    
    //发送消息
    [[EMClient sharedClient].chatManager sendMessage:message progress:nil completion:^(EMMessage *message, EMError *error) {
       
        NSLog(@"%@",message);
        NSLog(@"错误:%@",error);
    }];
    
}


#pragma mark - 接收消息回调
- (void)messagesDidRead:(NSArray *)aMessages{

    NSLog(@"已读消息");
}

- (void)messagesDidReceive:(NSArray *)aMessages{
    NSLog(@"接收到消息");
    //解析消息
    for (EMMessage * message in aMessages) {
        
        EMMessageBody * body = message.body;
        if (body.type == EMMessageBodyTypeText) {
            
            EMTextMessageBody * textBody = (EMTextMessageBody*)body;
            NSLog(@"%@",textBody.text);
        }
    }
}

#pragma mark - tableView 协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    return nil;
}

@end
