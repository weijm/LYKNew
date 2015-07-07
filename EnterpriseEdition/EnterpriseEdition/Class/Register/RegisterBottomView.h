//
//  RegisterBottomView.h
//  EnterpriseEdition
//
//  Created by lyk on 15/7/6.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomLabel;
@interface RegisterBottomView : UIView
{
    
    IBOutlet CustomLabel *agreementLab;
}
@property (nonatomic,copy) void (^clickedAction)(int index);
- (IBAction)agreementAction:(id)sender;
- (IBAction)nextSpet:(id)sender;

@end
