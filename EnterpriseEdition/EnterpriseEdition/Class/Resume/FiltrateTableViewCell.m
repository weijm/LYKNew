//
//  FiltrateTableViewCell.m
//  筛选cell视图
//
//  Created by wjm on 15/7/13.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "FiltrateTableViewCell.h"

@implementation FiltrateTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//重置编辑视图
-(void)resetEditTextField
{
    _contentTextFiled.placeholder = @"不限";
    _contentTextFiled.text = nil;
    
}
//设置编辑内容
-(void)setEditContent:(NSObject*)object
{
    if ([object isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary*)object;
        _contentTextFiled.text = [dic objectForKey:@"content"];
        
    }
}


@end
