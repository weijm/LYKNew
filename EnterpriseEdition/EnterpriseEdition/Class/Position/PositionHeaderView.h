//
//  PositionHeaderView.h
//  职位页面顶部的headerView
//
//  Created by wjm on 15/7/22.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PositionHeaderView : UIView
{
    
    IBOutlet UIView *btBg;
    
    UIView *subbg;
}
@property (nonatomic,copy)void(^chooseHeaderBtAction)(NSInteger index);
@end
