//
//  FiltrateView.h
//  筛选条件页面
//
//  Created by wjm on 15/7/13.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FiltrateViewDelegate <NSObject>
//选中某一行进行编辑
-(void)didSelectedRow:(int)row;
//确定或取消的触发事件 yes确定 no取消
-(void)makeSureOrCancelAction:(BOOL)sureOrCancel Conditions:(NSArray*)conditionArray;
@end
@interface FiltrateView : UIView<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UITableView *filtrateTableView;
    //标题数组
    NSMutableArray *titleArray;
    //内容数组
    NSMutableArray *contentArray;
    //编辑筛选条件的个数
    int editCount;
    //标志是否重置
    BOOL isReset;
    
    //确认按钮
    
    IBOutlet UIButton *sureBt;
    
}
@property (nonatomic,weak)id<FiltrateViewDelegate> delegate;


/**
 根据选择不同的简历筛选标题不同
 */
-(void)changeTitleArray:(int)index;
/**
 刷新指定行
 */
-(void)reloadTableView:(int)row withContent:(NSDictionary*)contentDic;

@end
