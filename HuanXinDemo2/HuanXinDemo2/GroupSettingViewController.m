//
//  GroupSettingViewController.m
//  HuanXinDemo2
//
//  Created by 余婷 on 2016/12/14.
//  Copyright © 2016年 余婷. All rights reserved.
//

#import "GroupSettingViewController.h"
#import "YTToolManager.h"


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
        
        //同意加群申请
        [[EMClient sharedClient].groupManager approveJoinGroupRequest:aGroupId sender:aInviter completion:^(EMGroup *aGroup, EMError *aError) {
            NSLog(@"申请入群成功");
        }];
    }];
    
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"拒绝" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

        //拒绝加群申请
        [[EMClient sharedClient].groupManager declineJoinGroupRequest:aGroupId sender:aInviter reason:@"你不符合要求" completion:^(EMGroup *aGroup, EMError *aError) {
           
            if (!aError) {
                
                NSLog(@"拒绝成功");
            }
            
        }];
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
    [[YTToolManager shareManager] showAlertViewWithMessage:[NSString stringWithFormat:@"%@申请加入群",aUsername] title:@"申请" sureTitle:@"同意" cancelTitle:@"不同意" inController:self sureAction:^{
        
        NSLog(@"同意");
        [[EMClient sharedClient].groupManager approveJoinGroupRequest:aGroup.groupId sender:aUsername completion:^(EMGroup *aGroup, EMError *aError) {
            NSLog(@"申请进群成功");
        }];
        
    } cancelAction:^{
       
        NSLog(@"拒绝");
    }];
    
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
