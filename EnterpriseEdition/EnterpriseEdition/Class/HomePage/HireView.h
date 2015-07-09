//
//  HireView.h
//  应聘部分的视图
//
//  Created by wjm on 15/7/8.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HireView : UIView
{
    
    IBOutlet UILabel *lab1;
 
    IBOutlet UILabel *lab2;
    
    IBOutlet UILabel *lab3;
    IBOutlet UILabel *lab4;
    IBOutlet UILabel *lab5;
    IBOutlet UILabel *lab6;
}
@property (nonatomic,copy) void(^clickedHire)(NSInteger index);
-(void)loadData:(NSArray*)array;
/**
 点击事件
 */
- (IBAction)clickedHireBtAction:(id)sender;

@end
