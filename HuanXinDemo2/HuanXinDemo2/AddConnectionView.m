//
//  AddConnectionView.m
//  HuanXinDemo2
//
//  Created by 余婷 on 2016/12/13.
//  Copyright © 2016年 余婷. All rights reserved.
//

#import "AddConnectionView.h"


@interface AddConnectionView()

@property (weak, nonatomic) IBOutlet UITextField *inputField;




@end

@implementation AddConnectionView

- (IBAction)cancelAction:(id)sender {
    
    [self removeFromSuperview];
}

- (IBAction)addAction2:(id)sender {
    
    NSString * text = self.inputField.text;
    
    self.addActionBlock(self.isGrounp,text);
}



@end
