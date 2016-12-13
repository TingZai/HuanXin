//
//  AppDelegate.m
//  HuanXinDemo2
//
//  Created by 余婷 on 2016/12/12.
//  Copyright © 2016年 余婷. All rights reserved.
//

#import "AppDelegate.h"
#import "EMSDK.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //1.环信
    //环信注册APPKey
    EMOptions * options = [EMOptions optionsWithAppkey:@"1109161212115191#test2"];
    //设置推送证书名
//    options.apnsCertName = @""
    
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    return YES;
}


- (void)applicationDidEnterBackground:(UIApplication *)application{

    [[EMClient sharedClient] applicationDidEnterBackground:application];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}




@end
