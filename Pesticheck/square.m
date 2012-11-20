//
//  square.m
//  Testing
//
//  Created by Chad Glen on 12-07-26.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "square.h"

@implementation square
@synthesize myPath=_myPath;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        _myPath=[[UIBezierPath alloc]init];
        _myPath=[UIBezierPath bezierPathWithRect:CGRectMake(2, 2, 105, 80)];
        [self setNeedsDisplay];
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [_myPath strokeWithBlendMode:kCGBlendModeNormal alpha:1.0];
    // Drawing code
}


@end
