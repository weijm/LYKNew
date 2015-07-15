//
//  HeaderView.h
//  简历首页最顶部视图
//
//  Created by wjm on 15/7/9.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderView : UIView
{
    
    UIView *subbg;
    
    IBOutlet UIView *chooseBg;
    
}

@property (nonatomic,copy)void(^chooseHeaderBtAction)(NSInteger index);
@property (nonatomic,copy)void(^clickedFiltrateAction)(void);
/**
 点击删选按钮 触发的事件
 */
- (IBAction)clickedFiltreateBtAction:(id)sender;
@end
