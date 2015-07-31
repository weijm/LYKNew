//
//  ClaimPositionTableViewCell.m
//  EnterpriseEdition
//
//  Created by lyk on 15/7/28.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "ClaimPositionTableViewCell.h"
#import "UIButton+Custom.h"
@implementation ClaimPositionTableViewCell

- (void)awakeFromNib {
    // Initialization code
    lineHeight.constant = 0.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)changeLocation:(BOOL)show Selected:(int)isSelected
{
    //是否选中的标记
    if (isSelected == 0) {
        [chooseBt setImage:[UIImage imageNamed:@"resume_choose_bt"] forState:UIControlStateNormal];
        chooseBt.specialMark = 0;
    }else
    {
        [chooseBt setImage:[UIImage imageNamed:@"resume_choose_selected_bt"] forState:UIControlStateNormal];
        chooseBt.specialMark = 1;
    }

}
- (IBAction)chooseAction:(id)sender {
    NSString *string = @"0";
    UIButton_Custom *bt = (UIButton_Custom*)sender;
    if (bt.specialMark == 1) {//从选中到取消
        [bt setImage:[UIImage imageNamed:@"resume_choose_bt"] forState:UIControlStateNormal];
        bt.specialMark = 0;
        string = @"0";
    }else//从未选中到选中
    {
        [bt setImage:[UIImage imageNamed:@"resume_choose_selected_bt"] forState:UIControlStateNormal];
        bt.specialMark = 1;
        string = @"1";
    }
    if ([_delegate respondsToSelector:@selector(clickedChooseBtAction:Selected:)]) {
        [_delegate clickedChooseBtAction:(int)self.tag Selected:string];
    }
    
}

@end
