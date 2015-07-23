//
//  FiltratePickerView.m
//  条件选择视图
//
//  Created by wjm on 15/7/13.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "FiltratePickerView.h"

@implementation FiltratePickerView
-(Location*)locate
{
    if (_locate==nil) {
        _locate = [[Location alloc] init];
    }
    return _locate;
}
- (instancetype)initWithFrame:(CGRect)frame pickerStyle:(PickerStyle)pickerStyle
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView *containerView = [[[UINib nibWithNibName:@"FiltratePickerView" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        CGRect newFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        containerView.frame = newFrame;
        [self addSubview:containerView];
        
        _resultDic = [[NSMutableDictionary alloc] init];
        pStyle = pickerStyle;
        
        [self loadData:0];
        
    }
    return self;
}
#pragma mark - PickerViewDelegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (pStyle == PickerStyleThreeColumn) {
        return 3;
    }else if (pStyle == PickerStyleTwoColumn) {
        return 2;
    }
    else
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
            if (pStyle == PickerStyleThreeColumn || pStyle == PickerStyleTwoColumn) {
                return [rightArray count];
                break;
            }
            
        case 2:
            if (pStyle == PickerStyleThreeColumn) {
                return [subRightArray count];
                break;
            }
        default:
            return 0;
            break;
    }
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pStyle == PickerStyleThreeColumn) {
        switch (component) {
            case 0:
                return [[leftArray objectAtIndex:row] objectForKey:@"state"];
                break;
            case 1:
                return [[rightArray objectAtIndex:row] objectForKey:@"city"];
                break;
            case 2:
                if ([subRightArray count]>0) {
                    return [subRightArray objectAtIndex:row];
                    break;
                }
            default:
                return @"";
                break;
        }
    }else if (pStyle == PickerStyleTwoColumn){
        switch (component) {
            case 0:
                return [[leftArray objectAtIndex:row] objectForKey:@"firstName"];
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
    }
    else
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
    if (pStyle == PickerStyleThreeColumn) {
        
        switch (component) {
            case 0:
                rightArray = [NSArray arrayWithArray:[[leftArray objectAtIndex:row] objectForKey:@"cities"]];
                [_pickerView selectRow:0 inComponent:1 animated:YES];
                [_pickerView reloadComponent:1];
                
                subRightArray = [[rightArray objectAtIndex:0] objectForKey:@"area"];
                [_pickerView selectRow:0 inComponent:2 animated:YES];
                [_pickerView reloadComponent:2];
                self.locate.state = [[leftArray objectAtIndex:row] objectForKey:@"state"];
                self.locate.city = [[rightArray objectAtIndex:0] objectForKey:@"city"];
                if ([subRightArray count] > 0) {
                    self.locate.district = [subRightArray objectAtIndex:0];
                } else{
                    self.locate.district = @"";
                }
                break;
            case 1:
                subRightArray = [[rightArray objectAtIndex:row] objectForKey:@"area"];
                [_pickerView selectRow:0 inComponent:2 animated:YES];
                [_pickerView reloadComponent:2];
                
                self.locate.city = [[rightArray objectAtIndex:row] objectForKey:@"city"];
                if ([subRightArray count] > 0) {
                    _locate.district = [subRightArray objectAtIndex:0];
                } else{
                    self.locate.district = @"";
                }
                break;
            case 2:
                if ([subRightArray count] > 0) {
                    self.locate.district = [subRightArray objectAtIndex:row];
                } else{
                    self.locate.district = @"";
                }
                break;
            default:
                break;
        }
        
    }
    else if (pStyle == PickerStyleTwoColumn){
        switch (component) {
            case 0:
                rightArray = [[leftArray objectAtIndex:row] objectForKey:@"secondArray"];
                
                [_pickerView selectRow:0 inComponent:1 animated:YES];
                [_pickerView reloadComponent:1];
                
                self.locate.state = [[leftArray objectAtIndex:row] objectForKey:@"firstName"];
                if ([rightArray count]>0) {
                    self.locate.city = [rightArray objectAtIndex:0];
                }
                break;
            case 1:
                self.locate.city = [rightArray objectAtIndex:row];
                break;
            default:
                break;
        }
        
    }
    else
    {
        switch (component) {
            case 0:
            {
                self.locate.country = [leftArray objectAtIndex:row];
            }
            break;
            default:
                break;
        }
   
    }
    
}
-(void)loadData:(int)index
{
    currentIndex = index;
    switch (index) {
        case 1:
            _titleLab.text = @"学    历 ";
            leftArray = [NSArray arrayWithObjects:@"不限",@"中专", @"大专",@"本科",@"硕士",@"博士",@"博士后",nil];
            self.locate.country = [leftArray objectAtIndex:0];
            break;
        case 2:
            _titleLab.text = @"期望薪资";
            leftArray = [NSArray arrayWithObjects:@"面议",@"2000-3000", @"3000-4000",@"5000-10000",@"10000-15000",@"15000以上",nil];
            self.locate.country = [leftArray objectAtIndex:0];
            break;
        case 0:
        case 3:
        case 7:
        {
            NSString *fileName;
            if (index == 0) {
                fileName = @"jobType.plist";
                if (_categoryType ==1) {
                    _titleLab.text = @"职位名称";
                }else
                {
                    _titleLab.text = @"简历来源";
                }
            }else if(index == 3)
            {
                _titleLab.text = @"专    业";
                fileName = @"major.plist";
            }else
            {
                _titleLab.text = @"所属行业";
                fileName = @"industry.plist";
           
            }
            leftArray = [NSArray arrayWithContentsOfFile:[Util getBundlePath:fileName]];
            self.locate.country = [leftArray objectAtIndex:0];
            NSDictionary *dic = [leftArray objectAtIndex:0];
            rightArray = [NSArray arrayWithArray:[dic objectForKey:@"secondArray"]];
            self.locate.state = [dic objectForKey:@"firstName"];//省
            if ([rightArray count]>0) {
                self.locate.city = [rightArray objectAtIndex:0];
            }
        }
            break;
        case 4:
            _titleLab.text = @"职位类型";
            leftArray = [NSArray arrayWithObjects:@"不限", @"全职",@"兼职",@"实习",nil];
            self.locate.country = [leftArray objectAtIndex:0];
            break;
        
        case 5:
        {
            _titleLab.text = @"期望城市";
            leftArray = [NSArray arrayWithContentsOfFile:[Util getBundlePath:@"city.plist"]];
            NSDictionary *dic = [leftArray objectAtIndex:0];
            rightArray = [NSArray arrayWithArray:[dic objectForKey:@"cities"]];
            self.locate.state = [dic objectForKey:@"state"];//省
            self.locate.city = [[rightArray objectAtIndex:0] objectForKey:@"city"];//市
            subRightArray = [[rightArray objectAtIndex:0] objectForKey:@"area"];
            if (subRightArray.count > 0) {//区
                self.locate.district = [subRightArray objectAtIndex:0];
            } else{
                self.locate.district = @"";
            }
            
        }
            break;
        case 6:
            _titleLab.text = @"工作经验";
            leftArray = [NSArray arrayWithObjects:@"不限", @"工作经验2年",@"工作经验3-5年",@"工作经验5年以上",@"工作经验10年以上",nil];
            self.locate.country = [leftArray objectAtIndex:0];
            break;
        case 8:
            _titleLab.hidden = YES;
            leftArray = [NSArray arrayWithObjects:@"上线", @"删除",@"下线",nil];
            self.locate.country = [leftArray objectAtIndex:0];
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

- (IBAction)finishedAction:(id)sender {
    
    if (pStyle == PickerStyleNormal) {//普通的
        if (self.locate.country !=nil) {
            [_resultDic setObject:self.locate.country forKey:@"content"];
            self.didSelectedPickerRow(currentIndex,_resultDic);
        }
        
    }else//地区
    {
        [_resultDic setObject:self.locate.state forKey:@"province"];
        [_resultDic setObject:self.locate.city forKey:@"city"];
        if (self.locate.district!=nil) {
            [_resultDic setObject:self.locate.district forKey:@"district"];
        }else{
            [_resultDic setObject:@"" forKey:@"district"];
        }
        
        self.didSelectedPickerRow(currentIndex,_resultDic);

    }
    [self cancelPicker];
}

@end
