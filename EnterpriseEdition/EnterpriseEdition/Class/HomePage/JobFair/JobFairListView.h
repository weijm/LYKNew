//
//  JobFairListView.h
//  EnterpriseEdition
//
//  Created by lyk on 15/9/21.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol JobFairListViewDelegate <NSObject>
@optional
//取消视图
-(void)cancelAction;
//选择某个招聘会
-(void)makeSureAction:(NSString*)fairId;
@end
@interface JobFairListView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *dataTableView;
    NSArray *dataArray;
    NSMutableArray *chooseArray;
}
@property (nonatomic,assign) id<JobFairListViewDelegate>delegate;
//初始化方法
-(instancetype)initWithFrame:(CGRect)frame AndData:(NSArray*)array;
//展示视图
-(void)showView:(UIView *)view;
//取消视图
-(void)cancelView;
@end
