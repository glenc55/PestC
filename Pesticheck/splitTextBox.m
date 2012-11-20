//
//  splitTextBox.m
//  Pesticheck
//
//  Created by Chad Glen on 12-10-07.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "splitTextBox.h"

@implementation splitTextBox

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        bezier =[[UIBezierPath alloc] init];
        bezier1 =[[UIBezierPath alloc] init];
        bezier2 =[[UIBezierPath alloc] init];
        bez=[[UIBezierPath alloc] init];
        bezier1.lineWidth=0.5;
        bezier2.lineWidth=0.5;
        bezier.lineWidth=0.5;
        bez.lineWidth=0.5;
        [bezier1 moveToPoint:CGPointMake(190, 9)];
        [bezier1 addLineToPoint:CGPointMake(190, 46)];
        [bezier moveToPoint:CGPointMake(0,102)];
        [bezier addLineToPoint:CGPointMake(290,102)];
        [bezier2 moveToPoint:CGPointMake(190, 175-13)];
        [bezier2 addLineToPoint:CGPointMake(190, 175+65)];
        [bez moveToPoint:CGPointMake(0,280)];
        [bez addLineToPoint:CGPointMake(290, 280)];
              
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [[UIColor blackColor] setStroke];
    [bezier stroke];
    [bezier1 stroke];
    [bezier2 stroke];
    [bez stroke];
    // Drawing code
}


@end
