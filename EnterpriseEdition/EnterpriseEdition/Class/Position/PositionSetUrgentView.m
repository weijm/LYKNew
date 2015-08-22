//
//  PositionSetUrgentView.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/23.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "PositionSetUrgentView.h"
#import "UIButton+Custom.h"

@implementation PositionSetUrgentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView *containerView = [[[UINib nibWithNibName:@"PositionSetUrgentView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];
        chooseBt1.specialMark =1 ;
        positionCount = 30;
        [self setLabParagraphStyle];
    }
    return self;
}

-(void)showView:(UIView *)view
{
    UIView *areaBg = [[UIView alloc] initWithFrame:view.frame];
    areaBg.backgroundColor = [UIColor clearColor];
    areaBg.tag = 250;
    [view addSubview:areaBg];
    
    UIView *alphBg = [[UIView alloc] initWithFrame:view.frame];
    alphBg.backgroundColor = [UIColor blackColor];
    alphBg.alpha = 0;
    [areaBg addSubview:alphBg];
    
    float height = [Util myXOrWidth:200];
    self.frame = CGRectMake(0, view.frame.size.height, kWidth-[Util myXOrWidth:40], height);
    self.center = view.center;
    [view addSubview:self];
    
    self.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        
        alphBg.alpha = 0.2;
        self.alpha = 1.0;

        
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelView)];
    [areaBg addGestureRecognizer:tap];
}
-(void)cancelView
{
    UIView *supView = [self superview];
    UIView *areaBg = [supView viewWithTag:250];
    [UIView animateWithDuration:0.3 animations:^{
        areaBg.alpha = 0;
        self.alpha = 0;
    } completion:^(BOOL finished){
        [areaBg removeFromSuperview];
        [self removeFromSuperview];
    }];
}
//确认的点击事件
- (IBAction)makeSure:(id)sender {
    [self cancelView];
    self.makeSurePositionUrgent(positionCount);
}
//选择简历个数的触发事件
- (IBAction)chooseCountAction:(id)sender {
    UIButton_Custom *bt = (UIButton_Custom*)sender;
    if (bt.specialMark == 0) {
        [bt setImage:[UIImage imageNamed:@"position_urgent_selected.png"] forState:UIControlStateNormal];
        bt.specialMark = 1;
    }else
    {
        [bt setImage:[UIImage imageNamed:@"position_urgent_select.png"] forState:UIControlStateNormal];
        bt.specialMark = 0;
    }
    NSArray *array = [NSArray arrayWithObjects:chooseBt1,chooseBt2,chooseBt3, nil];
    for (int i=0; i < [array count]; i++) {
        UIButton_Custom *tempBt = [array objectAtIndex:i];
        if (tempBt.tag != bt.tag) {
            [tempBt setImage:[UIImage imageNamed:@"position_urgent_select.png"] forState:UIControlStateNormal];
            tempBt.specialMark = 0;

        }
    }
    positionCount = (bt.tag ==1)?30:((bt.tag == 2)?50:100);
}
//关闭事件
- (IBAction)closeAction:(id)sender {
    [self cancelView];
    positionCount = 30;
}
-(void)setLabParagraphStyle
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 4;// 字体的行间距
    float fontSize = 12;
    if (kIphone4||kIphone5) {
        fontSize = 11;
    }
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:fontSize],
                                 NSParagraphStyleAttributeName:paragraphStyle,
                                 NSForegroundColorAttributeName:
                                     Rgb(0, 0, 0, 0.8)
                                 };
    proLab.attributedText = [[NSAttributedString alloc] initWithString:proLab.text attributes:attributes];
}

@end
