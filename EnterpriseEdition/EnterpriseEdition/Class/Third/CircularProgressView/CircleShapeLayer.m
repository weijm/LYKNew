//
//  CircleShapeLayer.m
//  CircularProgressControl
//
//  Created by Carlos Eduardo Arantes Ferreira on 22/11/14.
//  Copyright (c) 2014 Mobistart. All rights reserved.
//

#import "CircleShapeLayer.h"

@interface CircleShapeLayer ()

@property (assign, nonatomic) double initialProgress;
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, assign) CGRect frame;

@end

@implementation CircleShapeLayer

@synthesize percent = _percent;

- (instancetype)init {
    if ((self = [super init]))
    {
        [self setupLayer];
    }
    
    return self;
}

- (void)layoutSublayers {

    self.path = [self drawPathWithArcCenter];
    self.progressLayer.path = [self drawPathWithArcCenter];
    [super layoutSublayers];
}

- (void)setupLayer {
    
    self.path = [self drawPathWithArcCenter];
    UIColor *backColor = Rgb(240, 231, 236, 1.0);
    self.fillColor = backColor.CGColor;
    UIColor *progressColor = Rgb(180, 180, 180, 1.0);
    self.strokeColor = progressColor.CGColor;
    self.lineWidth = 3;
    
    self.progressLayer = [CAShapeLayer layer];
    self.progressLayer.path = [self drawPathWithArcCenter];
    
    self.progressLayer.fillColor = [UIColor clearColor].CGColor;
    self.progressLayer.strokeColor = [UIColor whiteColor].CGColor;
    self.progressLayer.lineWidth = 3;
    self.progressLayer.lineCap = kCALineCapRound;
    self.progressLayer.lineJoin = kCALineJoinRound;
    [self addSublayer:self.progressLayer];
    
}

- (CGPathRef)drawPathWithArcCenter {
    
    CGFloat position_y = self.frame.size.height/2;
    CGFloat position_x = self.frame.size.width/2; // Assuming that width == height
    return [UIBezierPath bezierPathWithArcCenter:CGPointMake(position_x, position_y)
                                          radius:position_y
                                      startAngle:(-M_PI/2)
                                        endAngle:(3*M_PI/2)
                                       clockwise:YES].CGPath;
}


- (void)setElapsedTime:(NSTimeInterval)elapsedTime {
    _initialProgress = [self calculatePercent:_elapsedTime toTime:_timeLimit];
    _elapsedTime = elapsedTime;
    
    self.progressLayer.strokeEnd = self.percent;
    [self startAnimation];
}

- (double)percent {
    
    _percent = [self calculatePercent:_elapsedTime toTime:_timeLimit];
    return _percent;
}

- (void)setProgressColor:(UIColor *)progressColor {
    self.progressLayer.strokeColor = progressColor.CGColor;
}

- (double)calculatePercent:(NSTimeInterval)fromTime toTime:(NSTimeInterval)toTime {
    
    if ((toTime > 0) && (fromTime > 0)) {
        
        CGFloat progress = 0;
        
        progress = fromTime / toTime;
        
        if ((progress * 100) > 100) {
            progress = 1.0f;
        }
        
//        NSLog(@"Percent = %f", progress);
        
        return progress;
    }
    else
        return 0.0f;
}

- (void)startAnimation {
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1.0;
    pathAnimation.fromValue = @(self.initialProgress);
    pathAnimation.toValue = @(self.percent);
    pathAnimation.removedOnCompletion = YES;
    
    [self.progressLayer addAnimation:pathAnimation forKey:nil];
    
}

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
