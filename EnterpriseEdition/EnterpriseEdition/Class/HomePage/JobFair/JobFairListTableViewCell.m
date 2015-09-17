//
//  JobFairListTableViewCell.m
//  招聘会列表cell
//
//  Created by lyk on 15/9/16.
//  Copyright (c) 2015年 lyk. All rights reserved.
//

#import "JobFairListTableViewCell.h"

@implementation JobFairListTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)loadSubView:(NSDictionary*)dictionary
{
    
    for (UIView *view in [self.contentView subviews]) {
        [view removeFromSuperview];
    }
    
    //标题
    float edgeX = [Util myXOrWidth:10];
    float edgeY = [Util myYOrHeight:10];
    float viewW = kWidth-edgeX*2;
    NSString *titStr = [dictionary objectForKey:@"title"];
     CGSize theStringSize = [titStr sizeWithFont:[UIFont systemFontOfSize:[self getLabFontSize]] maxSize:CGSizeMake(viewW, MAXFLOAT)];
    CGRect frame = CGRectMake(edgeX, edgeY, viewW, theStringSize.height);
    UILabel *tlab = [[UILabel alloc] initWithFrame:frame];
    tlab.font = [UIFont fontWithName:@"Helvetica-Bold" size:[self getLabFontSize]];
    tlab.font = [UIFont systemFontOfSize:[self getLabFontSize]];
    tlab.numberOfLines = 0;

    tlab.text = titStr;
    [self.contentView addSubview:tlab];
    NSArray *keyArr = [NSArray arrayWithObjects:@"time",@"address",@"organizer", nil];
    NSArray *titArr = [NSArray arrayWithObjects:@"招聘会时间:  ",@"具 体 地 点:  ",@"主 办 单 位:  ", nil];
    //具体信息
    float imgW = [Util myYOrHeight:10];
    float infoW = frame.size.width - imgW - edgeX;
    float iEdgeY = 5;
    CGRect imgFrame;
    CGRect infoFrame = CGRectMake(0, frame.size.height+frame.origin.y, 0, 0);
    UILabel *lab;
    for (int i =0; i<[keyArr count]; i++)
    {
        imgFrame = CGRectMake(edgeX, infoFrame.size.height+infoFrame.origin.y+iEdgeY+2, [Util myYOrHeight:10], [Util myYOrHeight:10]);
        UIImageView *imgIcon = [[UIImageView alloc] initWithFrame:imgFrame];
        imgIcon.image = [UIImage imageNamed:[NSString stringWithFormat:@"homepage_jobfair_icon%d",i]];
        [self.contentView addSubview:imgIcon];
        
        NSString *content = [NSString stringWithFormat:@"%@%@",[titArr objectAtIndex:i],[dictionary objectForKey:[keyArr objectAtIndex:i]]];
        theStringSize = [content sizeWithFont:[UIFont systemFontOfSize:[self getContentFontSize]] maxSize:CGSizeMake(infoW, MAXFLOAT)];
        infoFrame = CGRectMake(imgFrame.origin.x+imgW+10, infoFrame.origin.y+infoFrame.size.height+iEdgeY, infoW, theStringSize.height);
        lab = [[UILabel alloc] initWithFrame:infoFrame];
        lab.text = content;
        lab.textColor = Rgb(142, 145, 146, 1.0);
        lab.font = [UIFont systemFontOfSize:[self getContentFontSize]];
        lab.backgroundColor = [UIColor clearColor];
        lab.numberOfLines =0;
        [self.contentView addSubview:lab];
    }
    //背景
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, infoFrame.origin.y+infoFrame.size.height+[Util myYOrHeight:10])];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView insertSubview:bgView belowSubview:tlab];
    
    
    //按钮
    NSString *btTit = nil;
    UIColor *btbg = nil;
    BOOL btEnable = NO;
    int state = [[dictionary objectForKey:@"status"] intValue];
    if (state==-1) {
        btbg = Rgb(69, 170, 253, 1.0);
        btTit = @"立即报名";
        btEnable = YES;
    }else
    {
        btbg = Rgb(188, 189, 190, 1.0);
        btEnable = NO;
        if (state==1) {
            btTit = @"审核中...";
        }else if (state==0)
        {
            btTit = @"审核成功";
        }else if (state==2)
        {
            btTit = @"已开始";
        }else
        {
            btTit = @"已结束";
        }
    }
    
    UIButton *bt = [[UIButton alloc] initWithFrame:CGRectMake(0, infoFrame.origin.y+infoFrame.size.height+[Util myYOrHeight:10], kWidth, [Util myYOrHeight:32])];
    bt.backgroundColor = btbg;
    [bt setTitle:btTit forState:UIControlStateNormal];
    [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    bt.titleLabel.font = [UIFont systemFontOfSize:[self getLabFontSize]];
    [bt addTarget:self action:@selector(clickedAction:) forControlEvents:UIControlEventTouchUpInside];
    bt.enabled = btEnable;
    [self.contentView addSubview:bt];
    
    if(_isMy&&state>=2)
    {
        bt.frame = CGRectMake(0, infoFrame.origin.y+infoFrame.size.height+[Util myYOrHeight:10], kWidth-[Util myXOrWidth:80], [Util myYOrHeight:32]);
        UIButton *getBt = [UIButton buttonWithType:UIButtonTypeCustom];
        getBt.frame = CGRectMake(kWidth-[Util myXOrWidth:80], bt.frame.origin.y, [Util myXOrWidth:80], [Util myYOrHeight:32]);
        getBt.backgroundColor = Rgb(69, 170, 253, 1.0);
        [getBt setTitle:@"收到的简历" forState:UIControlStateNormal];
        [getBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        getBt.titleLabel.font = [UIFont systemFontOfSize:[self getLabFontSize]];
        [getBt addTarget:self action:@selector(getResumeList) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:getBt];
    }
    
}
//初始化招聘会详情cell
-(void)loadSubViewInInfo:(NSDictionary*)dictionary
{
    for (UIView *view in [self.contentView subviews]) {
        [view removeFromSuperview];
    }
    if (self.tag ==0) {
        [self initFirstCell:dictionary];
    }else if(self.tag ==1)
    {
        [self initSecondCell:dictionary];
    }else
    {
        [self initThirdOrFourCell:dictionary];
    }
}
-(void)initFirstCell:(NSDictionary*)dictionary
{
    //标题
    float edgeX = [Util myXOrWidth:10];
    float edgeY = [Util myYOrHeight:10];
    float viewW = kWidth-edgeX*2;
    NSString *titStr = [dictionary objectForKey:@"title"];
    CGSize theStringSize = [titStr sizeWithFont:[UIFont systemFontOfSize:[self getLabFontSize]] maxSize:CGSizeMake(viewW, MAXFLOAT)];
    CGRect frame = CGRectMake(edgeX, edgeY, viewW, theStringSize.height);
    UILabel *tlab = [[UILabel alloc] initWithFrame:frame];
    tlab.font = [UIFont fontWithName:@"Helvetica-Bold" size:[self getLabFontSize]];
    tlab.font = [UIFont systemFontOfSize:[self getLabFontSize]];
    tlab.numberOfLines = 0;
    
    tlab.text = titStr;
    [self.contentView addSubview:tlab];
    NSArray *keyArr = [NSArray arrayWithObjects:@"time",@"address",@"organizer", nil];
    NSArray *titArr = [NSArray arrayWithObjects:@"招聘会时间:  ",@"具 体 地 点:  ",@"主 办 单 位:  ", nil];
    //具体信息
    float imgW = [Util myYOrHeight:10];
    float infoW = frame.size.width - imgW - edgeX;
    float iEdgeY = 5;
    CGRect imgFrame;
    CGRect infoFrame = CGRectMake(0, frame.size.height+frame.origin.y, 0, 0);
    UILabel *lab;
    for (int i =0; i<[keyArr count]; i++)
    {
        imgFrame = CGRectMake(edgeX, infoFrame.size.height+infoFrame.origin.y+iEdgeY+2, [Util myYOrHeight:10], [Util myYOrHeight:10]);
        UIImageView *imgIcon = [[UIImageView alloc] initWithFrame:imgFrame];
        imgIcon.image = [UIImage imageNamed:[NSString stringWithFormat:@"homepage_jobfair_icon%d",i]];
        [self.contentView addSubview:imgIcon];
        
        NSString *content = [NSString stringWithFormat:@"%@%@",[titArr objectAtIndex:i],[dictionary objectForKey:[keyArr objectAtIndex:i]]];
        theStringSize = [content sizeWithFont:[UIFont systemFontOfSize:[self getContentFontSize]] maxSize:CGSizeMake(infoW, MAXFLOAT)];
        infoFrame = CGRectMake(imgFrame.origin.x+imgW+10, infoFrame.origin.y+infoFrame.size.height+iEdgeY, infoW, theStringSize.height);
        lab = [[UILabel alloc] initWithFrame:infoFrame];
        lab.text = content;
        lab.textColor = Rgb(142, 145, 146, 1.0);
        lab.font = [UIFont systemFontOfSize:[self getContentFontSize]];
        lab.backgroundColor = [UIColor clearColor];
        lab.numberOfLines =0;
        [self.contentView addSubview:lab];
    }
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, infoFrame.size.height+infoFrame.origin.y+10, kWidth, 0.5)];
    line.backgroundColor = [UIColor grayColor];
    line.alpha = 0.2;
    [self.contentView addSubview:line];
}
-(void)initSecondCell:(NSDictionary*)dictionary
{
    [self initCellTitle:(int)self.tag];
    
    float viewY = [Util myYOrHeight:10]*2+18;
    float imgW = [Util myXOrWidth:200];
    float imgH = [Util myYOrHeight:140];
    UIImageView *locationImg = [[UIImageView alloc] initWithFrame:CGRectMake((kWidth-imgW)/2, viewY, imgW, imgH)];
    locationImg.backgroundColor = Rgb(188, 188, 188, 0.5);
    [self.contentView addSubview:locationImg];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, viewY+imgH+[Util myYOrHeight:10], kWidth, 0.5)];
    line.backgroundColor = [UIColor grayColor];
    line.alpha = 0.2;
    [self.contentView addSubview:line];
}
-(void)initThirdOrFourCell:(NSDictionary*)dictionary
{
    [self initCellTitle:(int)self.tag];
    float viewY = [Util myYOrHeight:10]*2+18;
    float viewW = kWidth-[Util myXOrWidth:10]*2;
    
    NSString *content = nil;
    if (self.tag == 2) {
        content = [dictionary objectForKey:@"info"];
    }else
    {
        content = [dictionary objectForKey:@"note"];
    }
    
    CGSize theStringSize = [content sizeWithFont:[UIFont systemFontOfSize:[self getContentFontSize]] maxSize:CGSizeMake(viewW, MAXFLOAT)];
    UILabel *lab;
    lab = [[UILabel alloc] initWithFrame:CGRectMake([Util myXOrWidth:10], viewY, viewW, theStringSize.height)];
    lab.text = content;
    lab.font = [UIFont systemFontOfSize:[self getContentFontSize]];
    lab.backgroundColor = [UIColor clearColor];
    lab.numberOfLines =0;
    [self.contentView addSubview:lab];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, viewY+theStringSize.height+[Util myYOrHeight:10], kWidth, 0.5)];
    line.backgroundColor = [UIColor grayColor];
    line.alpha = 0.2;
    [self.contentView addSubview:line];
}

-(void)initCellTitle:(int)index
{
    NSString *content = nil;
    if (index==1) {
        content = @"| 招聘会平面图";
    }else if (index==2)
    {
        content = @"| 招聘会简介";
    }else
    {
        content = @"| 特别提示";
    }
    float edgeX =[Util myXOrWidth:10];
    float infoW = kWidth - edgeX*2;
    CGRect infoFrame = CGRectMake(edgeX,[Util myYOrHeight:10], infoW, 18);
    UILabel *lab;
   
    
    lab = [[UILabel alloc] initWithFrame:infoFrame];
    lab.text = content;
    lab.textColor = Rgb(142, 145, 146, 1.0);
    lab.font = [UIFont systemFontOfSize:[self getContentFontSize]];
    lab.backgroundColor = [UIColor clearColor];
    lab.numberOfLines =0;
    [self.contentView addSubview:lab];
}

-(float)getLabFontSize
{
    if (kIphone6||kIphone6plus) {
        return 15;
    }else
    {
        return 14;
    }
}
-(float)getContentFontSize
{
    if (kIphone6||kIphone6plus) {
        return 13;
    }else
    {
        return 12;
    }

}
-(void)clickedAction:(id)sender
{
    self.clickedAction((int)self.tag,NO);
}
-(void)getResumeList
{
    self.clickedAction((int)self.tag,YES);
}
@end
