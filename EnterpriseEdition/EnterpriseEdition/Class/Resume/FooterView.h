//
//  FooterView.h
//  EnterpriseEdition
//
//  Created by lyk on 15/7/11.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FooterView : UIView
{
    
    IBOutlet UIView *subView;
}
@property (nonatomic,copy)void(^chooseFooterBtAction)(NSInteger index,BOOL isAll);

@property (nonatomic) int position; //0其他 1 职位页面的编辑footer 2职位详情页面的footerView 3信息页面的编辑footer 4认领职位页面的footerView
/**
 设置全部编辑的各个按钮
 */
-(void)loadEditButton:(int)index;
/**
 设置按钮可点击或不可点击
 */
-(void)setButton:(NSArray*)array Enable:(BOOL)isEnable;
/**
 取消全选按钮 被选中的状态
 */
-(void)revertChooseBtByIndex:(int)index;
/**
 显示footerView
 */
-(void)showFooterView:(UIView*)supview;
/**
 取消footerView
 */
-(void)cancelFooterView;
@end
