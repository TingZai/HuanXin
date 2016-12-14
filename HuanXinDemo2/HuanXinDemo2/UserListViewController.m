//
//  UserListViewController.m
//  HuanXinDemo2
//
//  Created by 余婷 on 2016/12/13.
//  Copyright © 2016年 余婷. All rights reserved.
//

#import "UserListViewController.h"
#import "ListMenuView.h"
#import "AddConnectionView.h"
#import "AddGrounpView.h"
#import "CreatGrounpViewController.h"


@interface UserListViewController ()<EMContactManagerDelegate,EMUserListViewControllerDataSource>

@property(nonatomic,strong) ListMenuView * menuView;
@property(nonatomic,strong) AddConnectionView * addConnectionView;
@property(nonatomic,strong) AddGrounpView * addGrounpView;

@end

@implementation UserListViewController

- (void)loadView{

    [super loadView];
    self.dataSource = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //监听加好友请求
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
    
    [self showRefreshFooter];
    [self showRefreshHeader];
    
    //设置文字颜色
    [[EaseUserCell appearance] setTitleLabelColor:[UIColor greenColor]];
    
    //获取群主信息
    [self getAllGrounp];
    
}

#pragma mark - EMUserListViewControllerDataSource
- (id<IUserModel>)userListViewController:(EaseUsersListViewController *)userListViewController
                           modelForBuddy:(NSString *)buddy{

    id<IUserModel> model = nil;
    model = [[EaseUserModel alloc] initWithBuddy:buddy];
    model.avatarImage = [UIImage imageNamed:@"avatarImage_A"];
    model.avatarURLPath = @"http://img5.duitang.com/uploads/item/201410/16/20141016104649_itaAr.thumb.224_0.png";   //头像网络地址
//    model.nickname = @""; //昵称
    return model;
}

#pragma mark - EMContactManagerDelegate
#pragma mark -- 收到好友请求回调
- (void)friendRequestDidReceiveFromUser:(NSString *)aUsername message:(NSString *)aMessage{

    NSLog(@"有人想加你为好友");
    NSLog(@"%@,%@",aUsername,aMessage);
    
    UIAlertController * alsertC = [UIAlertController alertControllerWithTitle:@"有人想加你为好友" message:aMessage preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * sureAction = [UIAlertAction actionWithTitle:@"同意" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
#pragma mark --通过好友添加
        [[EMClient sharedClient].contactManager acceptInvitationForUsername:aUsername];
    }];
    
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"不同意" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
#pragma mark -- 拒绝加好友申请
        [[EMClient sharedClient].contactManager declineInvitationForUsername:aUsername];
    }];
    
    [alsertC addAction:sureAction];
    [alsertC addAction:cancelAction];
    [self presentViewController:alsertC animated:YES completion:nil];
}

#pragma mark -- 好友申请处理结果  
//好友申请被通过
- (void)friendRequestDidApproveByUser:(NSString *)aUsername{
    NSLog(@"%@通过了你的好友请求",aUsername);
    //刷新好友列表
    [self tableViewDidTriggerHeaderRefresh];
    
}

//好友申请被拒绝
- (void)friendRequestDidDeclineByUser:(NSString *)aUsername{

    NSLog(@"%@拒绝了你的好友请求",aUsername);
}







#pragma mark - 懒加载
- (AddGrounpView *)addGrounpView{

    if (_addGrounpView == nil) {
        
       _addGrounpView = [[NSBundle mainBundle] loadNibNamed:@"AddGrounpView" owner:self options:nil].lastObject;
        
        _addGrounpView.searchGrounp = ^(NSString * grounp){
        
            NSLog(@"搜索群");
            [self creatGrounpAction];
            [_addGrounpView removeFromSuperview];
        };
        _addGrounpView.creatGrounp = ^(void){
        
            NSLog(@"创建群");
            [_addGrounpView removeFromSuperview];
        };
    }
    
    return _addGrounpView;
}

- (AddConnectionView *)addConnectionView{
    
    if (_addConnectionView == nil) {
        
        _addConnectionView = [[NSBundle mainBundle] loadNibNamed:@"AddConnectionView" owner:nil options:nil].lastObject;
        _addConnectionView.frame = CGRectMake(0, 0, 250, 200);
        _addConnectionView.center = self.view.center;
        
        //添加联系人/群组
        _addConnectionView.addActionBlock = ^(BOOL isGrounp, NSString * userName){
        
            
            if (isGrounp) {
                [self addGroup:userName];
            }else{
            
                [self addFriend:userName];
            }
            
            [self.addConnectionView removeFromSuperview];
        };
    }
    
    return _addConnectionView;

    
}

- (ListMenuView *)menuView{

    if (_menuView == nil) {
        
        _menuView = [[NSBundle mainBundle] loadNibNamed:@"ListMenuView" owner:nil options:nil].lastObject;
        _menuView.backgroundColor = [UIColor redColor];
        _menuView.frame = CGRectMake(250, 70, 80, 110);
        [self.tableView addSubview:_menuView];
        _menuView.hidden = YES;
        
        self.menuView.addFirend = ^(void){
            
            NSLog(@"添加联系人");
            self.addConnectionView.isGrounp = NO;
            [self.tableView addSubview:self.addConnectionView];
            self.menuView.hidden = YES;
        };
        
        self.menuView.addGrounp = ^(void){
            
            NSLog(@"添加群组");
            [self.tableView addSubview:self.addGrounpView];
            self.menuView.hidden = YES;
        };
    }
    
    return _menuView;
}
#pragma mark - 群操作  
//获取相关的所有的群
- (void)getAllGrounp{

    //从服务器获取所有的群
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        EMError *error = nil;
        NSArray *myGroups = [[EMClient sharedClient].groupManager getMyGroupsFromServerWithError:&error];
        for (EMGroup * group in myGroups) {
            NSLog(@"A:%@",group.members);
            //获取群详情
            EMGroup *tgroup = [[EMClient sharedClient].groupManager fetchGroupInfo:group.groupId includeMembersList:YES error:&error];
            
            NSLog(@"B:%@",tgroup.groupId);
            
        }
        
    });
    
}

- (void)getGroupInfoWithId:(NSString *)groupId{

    
}

//创建群
- (void)creatGrounpAction{

    CreatGrounpViewController * creatV = [[CreatGrounpViewController alloc] init];
    creatV.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:creatV animated:YES];
}

- (void)addCrounpAction{

    
}


#pragma mark - 添加联系人
- (void)addFriend:(NSString *)userName{

    [[EMClient sharedClient].contactManager addContact:userName message:@"我想加你为好友" completion:^(NSString *aUsername, EMError *aError) {
        NSLog(@"添加好友");
        NSLog(@"%@",aUsername);
        NSLog(@"%@",aError);
        
    }];
}

#pragma mark - 添加群组
- (void)addGroup:(NSString *)userName{

    
}

#pragma mark - 按钮点击

- (IBAction)showAddList:(id)sender {
    
    if (self.menuView.hidden) {
        self.menuView.hidden = NO;
        
    }else{
    
        self.menuView.hidden = YES;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
