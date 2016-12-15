//
//  AddGrounpView.h
//  HuanXinDemo2
//
//  Created by 余婷 on 2016/12/14.
//  Copyright © 2016年 余婷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddGrounpView : UIView

@property(nonatomic,copy) void(^searchGrounp)(NSString *);
@property(nonatomic,copy) void(^creatGrounp)(NSString *);

@end
