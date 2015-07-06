//
//  ViewBackground.m
//  browserExtract
//
//  Created by Navaneethan Sivabalaviknarajah on 2015-07-06.
//  Copyright (c) 2015 Navaneethan Sivabalaviknarajah. All rights reserved.
//

#import "ViewBackground.h"

@implementation ViewBackground


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    float polySize = 60; // change this
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGAffineTransform t0 = CGContextGetCTM(context);
    t0 = CGAffineTransformInvert(t0);
    CGContextConcatCTM(context, t0);
    
    //Begin drawing setup
    CGContextBeginPath(context);
    CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
    CGContextSetLineWidth(context, 2.0);
    
    CGPoint center;
    
    //Start drawing polygon
    center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
    CGContextMoveToPoint(context, center.x, center.y + polySize);
    for(int i = 1; i < 6; ++i)
    {
        CGFloat x = polySize * sinf(i * 2.0 * M_PI / 6);
        CGFloat y = polySize * cosf(i * 2.0 * M_PI / 6);
        CGContextAddLineToPoint(context, center.x + x, center.y + y);
    }
    
    //Finish Drawing
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathStroke);
    CGContextRestoreGState(context);
}

@end
