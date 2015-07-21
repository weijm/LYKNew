//
//  CircleProgressView.h
//  CircularProgressControl
//
//  Created by Carlos Eduardo Arantes Ferreira on 22/11/14.
//  Copyright (c) 2014 Mobistart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleProgressView : UIControl

@property (nonatomic) NSTimeInterval elapsedTime;

@property (nonatomic) NSTimeInterval timeLimit;

@property (nonatomic, retain) NSString *status;

@property (nonatomic) NSTimeInterval remainingTime;

@property (assign, nonatomic, readonly) double percent;

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
