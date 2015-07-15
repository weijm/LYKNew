//
//  FiltratePickerView.m
//  条件选择视图
//
//  Created by wjm on 15/7/13.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "FiltratePickerView.h"

@implementation FiltratePickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView *containerView = [[[UINib nibWithNibName:@"FiltratePickerView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];
        
        _resultDic = [[NSMutableDictionary alloc] init];
        pStyle = PickerStyleNormal;
        [self loadData:0];
    }
    return self;
}
#pragma mark - PickerViewDelegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (pStyle == PickerStyleArea) {
        return 2;
    }else
    {
        return 1;
    }
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [leftArray count];
            break;
        case 1:
            if (pStyle == PickerStyleArea) {
                return [rightArray count];
                break;
            }
        default:
            return 0;
            break;
    }
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pStyle == PickerStyleArea) {
        switch (component) {
            case 0:
                return [leftArray objectAtIndex:row];
                break;
            case 1:
                if ([rightArray count]>0) {
                    return [rightArray objectAtIndex:row];
                    break;
                }
            default:
                return @"";
                break;
        }
    }else
    {
        switch (component) {
            case 0:
                return [leftArray objectAtIndex:row];
                break;
            default:
                return @"";
                break;
        }
    }
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pStyle == PickerStyleArea) {
        switch (component) {
            case 0:
                [_resultDic setObject:[leftArray objectAtIndex:row] forKey:@"province"];
                break;
            case 1:
                [_resultDic setObject:[leftArray objectAtIndex:row] forKey:@"city"];
                break;
                
            default:
                break;
        }
        
    }else
    {
        switch (component) {
            case 0:
            {
                [_resultDic setObject:[leftArray objectAtIndex:row] forKey:@"content"];
            }
            break;
            default:
                break;
        }
   
    }
    self.didSelectedPickerRow(currentIndex,_resultDic);
}
-(void)loadData:(int)index
{
    currentIndex = index;
    switch (index) {
        case 0:
            leftArray = [NSArray arrayWithObjects:@"职位1", @"职位1",@"职位1",@"职位1",@"职位1",nil];
            break;
        case 1:
            leftArray = [NSArray arrayWithObjects:@"已查看", @"未查看",nil];
            break;
        case 2:
            leftArray = [NSArray arrayWithObjects:@"中专", @"大专",@"本科",@"硕士",@"博士",@"博士后",nil];
            break;
        case 3:
            leftArray = [NSArray arrayWithObjects:@"2000-3000", @"3000-4000",@"5000-10000",@"10000-15000",@"15000以上",@"面议",nil];
            break;
        case 4:
            leftArray = [NSArray arrayWithObjects:@"UI设计", @"计算机专业",@"软件工程",@"电子自动化",@"会计",@"外语",nil];
            break;
        case 5:
            leftArray = [NSArray arrayWithObjects:@"UI设计", @"计算机专业",@"软件工程",@"电子自动化",@"会计",@"外语",nil];
            break;
        case 6:
            leftArray = [NSArray arrayWithObjects:@"没有工作经验", @"工作经验2年",@"工作经验3-5年",@"工作经验5年以上",@"工作经验10年以上",nil];
            break;
            
        default:
            break;
    }
    [_pickerView reloadAllComponents];
}
#pragma mark - animation
-(void)showInView:(UIView *)view
{
    UIView *areaBg = [[UIView alloc] initWithFrame:view.frame];
    areaBg.backgroundColor = [UIColor clearColor];
    areaBg.tag = 250;
    [view addSubview:areaBg];
    
    UIView *alphBg = [[UIView alloc] initWithFrame:view.frame];
    alphBg.backgroundColor = [UIColor grayColor];
    alphBg.alpha = 0;
    [areaBg addSubview:alphBg];
    
    float height = [Util myYOrHeight:216];
    self.frame = CGRectMake(0, view.frame.size.height, kWidth, height);
    [view addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        alphBg.alpha = 0.8;
        CGRect frame = self.frame;
        frame.origin.y = view.frame.size.height-self.frame.size.height;
        self.frame = frame;
        
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelPicker)];
    [areaBg addGestureRecognizer:tap];
}
-(void)cancelPicker
{
    UIView *supView = [self superview];
    UIView *areaBg = [supView viewWithTag:250];
    float height = [Util myYOrHeight:216];
    [UIView animateWithDuration:0.3 animations:^{
        areaBg.alpha = 0;
        CGRect frame = self.frame;
        frame.origin.y = frame.origin.y+height;
        self.frame = frame;
    } completion:^(BOOL finished){
        [areaBg removeFromSuperview];
        [self removeFromSuperview];
    }];
}

@end
