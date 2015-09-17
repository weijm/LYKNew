//
//  JobFairHeaderView.h
//  招聘会列表
//
//  Created by lyk on 15/9/16.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobFairHeaderView : UIView
{
    UIView *subbg;
}
@property (nonatomic,copy)void(^chooseHeaderBtAction)(NSInteger index);
@property (nonatomic,copy) void(^makeCallAction)(NSString*number);

-(void)chooseBtAction:(NSInteger)index;

//修改header的界面
-(void)changeButtonBgAndTextColor:(int)index;
@end
