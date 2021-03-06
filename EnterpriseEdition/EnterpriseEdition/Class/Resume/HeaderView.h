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
    
    __weak IBOutlet UIView *chooseBg;
    
    __weak IBOutlet UIButton *filtrateBt;
    __weak IBOutlet UIView *arrowBg;
    
    
}

@property (nonatomic,copy)void(^chooseHeaderBtAction)(NSInteger index);
@property (nonatomic,copy)void(^clickedFiltrateAction)(void);
/**
 点击筛选按钮 触发的事件
 */
- (IBAction)clickedFiltreateBtAction:(id)sender;
/**
 点击headerView上的按钮的触发事件
 */
-(void)chooseBtAction:(NSInteger)index;

//修改header的界面
-(void)changeButtonBgAndTextColor:(int)index;
@end
