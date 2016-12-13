//
//  ListMenuView.h
//  HuanXinDemo2
//
//  Created by 余婷 on 2016/12/13.
//  Copyright © 2016年 余婷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListMenuView : UIView

@property(nonatomic,copy) void(^addFirend)(void);
@property(nonatomic,copy) void(^addGrounp)(void);

@end
