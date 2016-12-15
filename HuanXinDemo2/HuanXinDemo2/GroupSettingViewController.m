//
//  GroupSettingViewController.m
//  HuanXinDemo2
//
//  Created by 余婷 on 2016/12/14.
//  Copyright © 2016年 余婷. All rights reserved.
//

#import "GroupSettingViewController.h"


@interface GroupSettingViewController ()<EMGroupManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *memberNumber;


@end

@implementation GroupSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //注册群组回调
    [[EMClient sharedClient].groupManager addDelegate:self delegateQueue:nil];
    
    self.memberNumber.text = [NSString stringWithFormat:@"%d/%d",self.currentGroup.membersCount,self.currentGroup.setting.maxUsersCount];
}

#pragma mark - 回调方法
- (void)groupInvitationDidReceive:(NSString *)aGroupId
                          inviter:(NSString *)aInviter
                          message:(NSString *)aMessage{

    UIAlertController * alsertC = [UIAlertController alertControllerWithTitle:@"入群申请" message:aMessage preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * sureAction = [UIAlertAction actionWithTitle:@"同意" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[EMClient sharedClient].groupManager acceptInvitationFromGroup:aGroupId inviter:aInviter completion:^(EMGroup *aGroup, EMError *aError) {
           
            if (!aError) {
                
                NSLog(@"同意进群成功");
            }
            
        }];
    }];
    
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"拒绝" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

        
    }];
    
    [alsertC addAction:sureAction];
    [alsertC addAction:cancelAction];
    [self presentViewController:alsertC animated:YES completion:nil];
    
}

- (void)groupInvitationDidAccept:(EMGroup *)aGroup
                         invitee:(NSString *)aInvitee{

    NSLog(@"B同意邀请");
}

- (void)groupInvitationDidDecline:(EMGroup *)aGroup
                          invitee:(NSString *)aInvitee
                           reason:(NSString *)aReason{

    NSLog(@"B拒绝邀请");
}

- (void)didJoinGroup:(EMGroup *)aGroup
                     inviter:(NSString *)aInviter
                     message:(NSString *)aMessage{

    NSLog(@"被邀请的B加入了群组");
}

- (void)joinGroupRequestDidReceive:(EMGroup *)aGroup
                                      user:(NSString *)aUsername
                                    reason:(NSString *)aReason{

    NSLog(@"收到入群申请");
}

- (void)joinGroupRequestDidDecline:(NSString *)aGroupId
                            reason:(NSString *)aReason{

    NSLog(@"入群申请被拒绝");
}




#pragma mark - 添加群成员
- (IBAction)addMemberAction:(id)sender {
    
    EMError *error = nil;
    [[EMClient sharedClient].groupManager addOccupants:@[@"xiaogou",@"haha"] toGroup:self.currentGroup.groupId welcomeMessage:@"message" error:&error];
    if (!error) {
        
        NSLog(@"邀请成功");
    }
}


@end
