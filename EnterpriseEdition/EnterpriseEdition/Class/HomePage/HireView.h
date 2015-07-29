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
    
    IBOutlet NSLayoutConstraint *bt1Width;
    IBOutlet NSLayoutConstraint *bt1Height;
    
    IBOutlet NSLayoutConstraint *bt2Width;
    IBOutlet NSLayoutConstraint *bt2Height;
    
    IBOutlet NSLayoutConstraint *bt3Width;
    IBOutlet NSLayoutConstraint *bt3Height;
    
    IBOutlet NSLayoutConstraint *bt4Width;
    IBOutlet NSLayoutConstraint *bt4Height;
    
    IBOutlet NSLayoutConstraint *bt5Width;
    IBOutlet NSLayoutConstraint *bt5Height;
    
    IBOutlet NSLayoutConstraint *bt6Width;
    IBOutlet NSLayoutConstraint *bt6Height;
}
@property (nonatomic,copy) void(^clickedHire)(NSInteger index);
-(void)loadData:(NSArray*)array;
/**
 点击事件
 */
- (IBAction)clickedHireBtAction:(id)sender;

@end
