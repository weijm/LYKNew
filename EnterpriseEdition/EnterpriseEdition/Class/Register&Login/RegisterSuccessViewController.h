//
//  RegisterSuccessViewController.h
//  注册成功页面
//
//  Created by wjm on 15/7/27.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterSuccessViewController : BaseViewController
{
    
    __weak IBOutlet UIButton *infoBt;

    
    __weak IBOutlet UIButton *randomBt;

}
- (IBAction)pressBtAction:(id)sender;

@end
