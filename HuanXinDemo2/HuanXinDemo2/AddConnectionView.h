//
//  AddConnectionView.h
//  HuanXinDemo2
//
//  Created by 余婷 on 2016/12/13.
//  Copyright © 2016年 余婷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddConnectionView : UIView

//是否是群组（如果不是群组就是联系人）
@property(nonatomic,assign) BOOL isGrounp;

@property(nonatomic,copy) void(^addActionBlock)(BOOL,NSString*);

@end
