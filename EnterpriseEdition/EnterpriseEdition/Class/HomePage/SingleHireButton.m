//
//  SingleHireButton.m
//  首页聘部分的单个按钮视图
//
//  Created by lyk on 15/7/30.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "SingleHireButton.h"

@implementation SingleHireButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView *containerView = [[[UINib nibWithNibName:@"SingleHireButton" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];
        
        if (kIphone6plus) {
            itemBtHeight.constant = itemBtHeight.constant+6;
            itemBtWidth.constant = itemBtWidth.constant+6;
            itemBtY.constant = 10;
            itemLab.font = [UIFont systemFontOfSize:14];
        }else if (kIphone5||kIphone4)
        {
            itemBtY.constant = 23;
            itemLab.font = [UIFont systemFontOfSize:12];
            itemLabToItemBt.constant = -3;
        }
    }
    return self;
}
// 初始化按钮图片及文字
-(void)loadSubViewAndData:(NSDictionary*)dictionary
{
    NSString *imgStr = [NSString stringWithFormat:@"homepage_hire_icon%d",(int)self.tag+1];
    [itemBt setBackgroundImage:[UIImage imageNamed:imgStr] forState:UIControlStateNormal];
    
    //初始化文字
    if ([dictionary allKeys].count>1) {
        [self loadLabText:[dictionary objectForKey:@"string"] stytleStr:[dictionary objectForKey:@"substring"]];
    }else
    {
        [self loadLabText:[dictionary objectForKey:@"string"] stytleStr:@""];
        
    }
    
}
//点击事件
- (IBAction)clickedItemAction:(id)sender {
    self.clickedItem((int)self.tag);
}
-(void)changeSubViewTitle:(NSDictionary*)dictionary
{
    if ([dictionary allKeys].count>1) {
        [self loadLabText:[dictionary objectForKey:@"string"] stytleStr:[dictionary objectForKey:@"substring"]];
    }else
    {
         [self loadLabText:[dictionary objectForKey:@"string"] stytleStr:@""];
        
    }
}
-(void)loadLabText:(NSString*)string stytleStr:(NSString*)subStr
{
    NSRange range ;
    if ([subStr length]>0) {
        range = [string rangeOfString:subStr];
    }else
    {
        range = NSMakeRange(0, 0);
    }
    if (string == nil) {
        return;
    }
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:string];
    //设置字体颜色
    [attributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:Rgb(91, 147, 202, 1.0)
     
                          range:range];
    //设置下划线
    [attributedStr addAttribute:NSUnderlineStyleAttributeName
     
                          value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
     
                          range:range];
    float fontSize = 11.0;
    if (kIphone6plus) {
        fontSize = 13.0;
    }
    //设置字体大小
    [attributedStr addAttribute:NSFontAttributeName
     
                          value:[UIFont systemFontOfSize:fontSize]
     
                          range:range];
    itemLab.attributedText = attributedStr;
}

@end
