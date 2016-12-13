//
//  ConversationInfoViewController.m
//  HuanXinDemo2
//
//  Created by 余婷 on 2016/12/12.
//  Copyright © 2016年 余婷. All rights reserved.
//

#import "ConversationInfoViewController.h"

@interface ConversationInfoViewController ()
@property (weak, nonatomic) IBOutlet UITextField *messageField;

@end

@implementation ConversationInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)sendAction:(id)sender {
    //要发送的消息
    EMTextMessageBody * body = [[EMTextMessageBody alloc] initWithText:_messageField.text];
    //当前账号
    NSString * form = [[EMClient sharedClient] currentUsername];
    
    EMMessage * message = [[EMMessage alloc] initWithConversationID:self.conversaction.conversationId from:form to:@"xiaogou" body:body ext:nil];
    message.chatType = EMChatTypeChat;
    
    [[EMClient sharedClient].chatManager sendMessageReadAck:message completion:^(EMMessage *aMessage, EMError *aError) {
       
        NSLog(@"%@",aMessage.to);
        NSLog(@"错误:%@",aError);
    }];
    
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
