//
//  CellBottomView.h
//  EnterpriseEdition
//
//  Created by lyk on 15/7/9.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellBottomView : UIView
{
    //标签背景
    IBOutlet UIView *subBg;
}
/**
 加载标签
 */
-(void)loadAllLabel:(NSArray*)array;
@end
