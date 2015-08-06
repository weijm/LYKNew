//
//  HobbiesTableViewCell.h
//  特长/兴趣 自我评价 个人荣誉Cell
//
//  Created by wjm on 15/7/16.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TitleView;

@interface HobbiesTableViewCell : UITableViewCell
{
    
    __weak IBOutlet TitleView *titleView;

    
    __weak IBOutlet UITextField *emptyView;

    
    __weak IBOutlet UILabel *contentLab;

    
}
/**
 加载不同的内容 type: 0特长/兴趣 1自我评价 2个人荣誉
 */
-(void)loadContent:(NSString*)content type:(int)type;
@end
