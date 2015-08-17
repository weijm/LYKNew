//
//  SingleHireButton.h
//  首页聘部分的单个按钮视图
//
//  Created by lyk on 15/7/30.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SingleHireButton : UIView
{
    
    
    __weak IBOutlet NSLayoutConstraint *itemBtWidth;
    
    __weak IBOutlet NSLayoutConstraint *itemBtHeight;
    
    __weak IBOutlet NSLayoutConstraint *itemBtY;
   
    
    __weak IBOutlet UILabel *itemLab;
    
    __weak IBOutlet UIButton *itemBt;
    
 
    __weak IBOutlet NSLayoutConstraint *itemLabToItemBt;
   
}
@property(nonatomic,copy) void(^clickedItem)(int index);
@property(nonatomic) BOOL isValid;
/**
 初始化按钮图片及文字
 */
-(void)loadSubViewAndData:(NSDictionary*)dictionary;

/**
 点击事件
 */
- (IBAction)clickedItemAction:(id)sender;
@end
