//
//  AddGrounpView.m
//  HuanXinDemo2
//
//  Created by 余婷 on 2016/12/14.
//  Copyright © 2016年 余婷. All rights reserved.
//

#import "AddGrounpView.h"

@interface AddGrounpView()

@property (weak, nonatomic) IBOutlet UITextField *textField;


@end

@implementation AddGrounpView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)creatAction:(id)sender {
    
    self.searchGrounp(self.textField.text);
}
- (IBAction)cancelAction:(id)sender {
    
    [self removeFromSuperview];
}
- (IBAction)sureAction:(id)sender {
    
    NSLog(@"确定");
//    self.creatGrounp();
}






@end
