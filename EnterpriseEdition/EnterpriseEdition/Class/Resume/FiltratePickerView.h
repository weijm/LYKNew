//
//  FiltratePickerView.h
//  条件选择视图
//
//  Created by wjm on 15/7/13.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    PickerStyleNormal,
    PickerStyleArea
}PickerStyle;

@interface FiltratePickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>
{
    PickerStyle pStyle;
    //pickerView坐起第一列的数组
    NSArray *leftArray;
    //pickerView坐起第二列的数组
    NSArray *rightArray;
    //目前加载数据标记
    int currentIndex;
    //是否选择完成
    BOOL isFinished;
    NSString *provinceString;
}
@property (nonatomic,copy)void(^didSelectedPickerRow)(int row,NSDictionary *dictionary);
@property(strong,nonatomic) NSMutableDictionary *resultDic;
//pickerView上的titlab
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;

- (instancetype)initWithFrame:(CGRect)frame pickerStyle:(PickerStyle)pickerStyle;
//加载不同的pickerView的内容
-(void)loadData:(int)index;

-(void)showInView:(UIView*)view;

-(void)cancelPicker;
@end
