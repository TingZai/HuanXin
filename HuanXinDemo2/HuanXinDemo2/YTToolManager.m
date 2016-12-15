//
//  YTToolManager.m
//  HuanXinDemo2
//
//  Created by 余婷 on 2016/12/15.
//  Copyright © 2016年 余婷. All rights reserved.
//

#import "YTToolManager.h"

@implementation YTToolManager

+ (instancetype)shareManager{

    static YTToolManager * manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [YTToolManager new];
    });
    
    return manager;
}


- (void)showAlertViewWithMessage:(NSString *)message title:(NSString *)title sureTitle:(NSString *)sureTitle cancelTitle:(NSString *)cancelTitle inController:(UIViewController *)VC sureAction:(void (^)(void))sureAction cancelAction:(void (^)(void))cancelAction{

    UIAlertController * alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * sure = [UIAlertAction actionWithTitle:sureTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        sureAction();
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
       
        cancelAction();
    }];
    
    [alertC addAction:cancel];
    [alertC addAction:sure];
    
    [VC presentViewController:alertC animated:YES completion:nil];
    
}


@end
