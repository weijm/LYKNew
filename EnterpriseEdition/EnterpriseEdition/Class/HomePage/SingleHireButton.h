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
    
    IBOutlet NSLayoutConstraint *itemBtWidth;
    
    IBOutlet NSLayoutConstraint *itemBtHeight;
    IBOutlet NSLayoutConstraint *itemBtY;
    
    IBOutlet UILabel *itemLab;
    
    IBOutlet UIButton *itemBt;
    IBOutlet NSLayoutConstraint *itemLabToItemBt;
}
@property(nonatomic,copy) void(^clickedItem)(int index);
/**
 初始化按钮图片及文字
 */
-(void)loadSubViewAndData:(NSDictionary*)dictionary;

/**
 点击事件
 */
- (IBAction)clickedItemAction:(id)sender;
@end
