//
//  HireView.m
//  应聘部分的视图
//
//  Created by wjm on 15/7/8.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "HireView.h"

@implementation HireView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView *containerView = [[[UINib nibWithNibName:@"HireView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];
    }
    return self;
}

-(void)loadData:(NSArray*)array
{
    NSInteger count = array.count;
    for (int i =0; i < count; i++) {
        NSDictionary *dictionary = [array objectAtIndex:i];
        UILabel *lab;
        switch (i+1) {
            case 1:
                lab = lab1;
                break;
            case 2:
                lab = lab2;
                break;
            case 3:
                lab = lab3;
                break;
            case 4:
                lab = lab4;
                break;
            case 5:
                lab = lab5;
                break;
            case 6:
                lab = lab6;
                
                break;
                
            default:
                break;
        }
        [self loadLab:lab Text:[dictionary objectForKey:@"string"] stytleStr:[dictionary objectForKey:@"substring"]];
    }
}
-(void)loadLab:(UILabel*)lab Text:(NSString*)string stytleStr:(NSString*)subStr
{
    NSRange range = [string rangeOfString:subStr];
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:string];
    //设置字体颜色
    [attributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:Rgb(91, 147, 202, 1.0)
     
                          range:range];
    //设置下划线
    [attributedStr addAttribute:NSUnderlineStyleAttributeName
     
                          value:[NSNumber numberWithInteger:NSUnderlineStyleSingle]
     
                          range:range];
    //设置字体大小
    [attributedStr addAttribute:NSFontAttributeName
     
                          value:[UIFont systemFontOfSize:11.0]
     
                          range:range];
    lab.attributedText = attributedStr;
}
- (IBAction)clickedHireBtAction:(id)sender {
    UIButton *bt = (UIButton*)sender;
    NSInteger tag = bt.tag;
    self.clickedHire(tag);
}
@end
