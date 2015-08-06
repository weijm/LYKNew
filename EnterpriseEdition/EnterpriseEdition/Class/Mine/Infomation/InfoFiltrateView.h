//
//  InfoFiltrateView.h
//  EnterpriseEdition
//
//  Created by lyk on 15/7/24.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoFiltrateView : UIView
{
    __weak IBOutlet NSLayoutConstraint *lineHeight;

}
@property (nonatomic,copy) void(^touchAction)(int index);
/**
 显示infoFiltrateView
 */
-(void)showInView:(UIView *)view;
/**
 取消infoFiltrateView
 */
-(void)cancelView;
/**
 按钮的点击事件
 */
- (IBAction)chooseAction:(id)sender;

@end
