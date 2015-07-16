//
//  JobIntensionTableViewCell.h
//  求职意向Cell
//
//  Created by wjm on 15/7/16.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TitleView;

@interface JobIntensionTableViewCell : UITableViewCell
{
    
    IBOutlet TitleView *titleView;
    //内容为空时展示
    IBOutlet UITextField *emptyView;
    
}
@end
