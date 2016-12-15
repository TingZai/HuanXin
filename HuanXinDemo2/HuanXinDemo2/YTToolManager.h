//
//  YTToolManager.h
//  HuanXinDemo2
//
//  Created by 余婷 on 2016/12/15.
//  Copyright © 2016年 余婷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YTToolManager : NSObject

+ (instancetype)shareManager;

/**
 显示警告框
 */
- (void)showAlertViewWithMessage:(NSString *)message title:(NSString *)title sureTitle:(NSString*)sureTitle cancelTitle:(NSString *)cancelTitle inController:(UIViewController*)VC sureAction:(void(^)(void))sureAction cancelAction:(void(^)(void))cancelAction;




@end
