//
//  CreatGrounpViewController.m
//  HuanXinDemo2
//
//  Created by 余婷 on 2016/12/14.
//  Copyright © 2016年 余婷. All rights reserved.
//

#import "CreatGrounpViewController.h"
#import "EMSDK.h"

@interface CreatGrounpViewController ()

@property (weak, nonatomic) IBOutlet UITextField *maxUserCountFeild;
@property (weak, nonatomic) IBOutlet UISegmentedControl *grounpTypeFeild;
@property (weak, nonatomic) IBOutlet UITextField *grounpNameField;

@property (weak, nonatomic) IBOutlet UITextField *descriptionField;



@end

@implementation CreatGrounpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)creatAction:(id)sender {
    
    EMError *error = nil;
    EMGroupOptions *setting = [[EMGroupOptions alloc] init];
    setting.maxUsersCount = self.maxUserCountFeild.text.integerValue;
    
    switch (self.grounpTypeFeild.selectedSegmentIndex) {
        case 0:
            setting.style = EMGroupStylePrivateOnlyOwnerInvite;
            break;
        case 1:
            setting.style = EMGroupStylePrivateMemberCanInvite;
            break;
        case 2:
            setting.style = EMGroupStylePublicJoinNeedApproval;
            break;
        default:
            setting.style = EMGroupStylePublicOpenJoin;
            break;
    }
    
    
    EMGroup *group = [[EMClient sharedClient].groupManager createGroupWithSubject:self.grounpNameField.text description:self.descriptionField.text invitees:@[@"xiaogou",@"xiaohua"] message:@"邀请您加入群组" setting:setting error:&error];
    if(!error){
        NSLog(@"创建成功 -- %@",group);
    }
    
}




@end
