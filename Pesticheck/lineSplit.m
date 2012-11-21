//
//  lineSplit.m
//  photoSplit
//
//  Created by Chad Glen on 12-07-24.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "lineSplit.h"

@implementation lineSplit
@synthesize myPath=_myPath;
@synthesize vertLine=_vertLine;
@synthesize contr,test, whiteBox;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        contr=[[UIBezierPath alloc] init];
        test=[[UIBezierPath alloc] init];
        contr=[UIBezierPath bezierPathWithRect:CGRectMake(0,174, 160, 242)];
        test=[UIBezierPath bezierPathWithRect:CGRectMake(160, 174, 160, 242)];
        
        _myPath=[[UIBezierPath alloc] init];
        _myPath.lineWidth=2;
        [_myPath moveToPoint:CGPointMake(160, 174)];
        [_myPath addLineToPoint:CGPointMake(160, 416)];
        _vertLine=[[UIBezierPath alloc] init];
        _vertLine.lineWidth=2;
        [_vertLine moveToPoint:CGPointMake(0, 174)];
        [_vertLine addLineToPoint:CGPointMake(320, 174)];
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [[UIColor blackColor] setStroke];
    [_myPath stroke];
    [_vertLine stroke];
    [[UIColor cyanColor] setFill];
    [contr fillWithBlendMode:kCGBlendModeDarken alpha:0.1];
    [[UIColor greenColor] setFill];
    [test fillWithBlendMode:kCGBlendModeDarken alpha:0.1];
    [[UIColor whiteColor] setFill];
    [whiteBox fillWithBlendMode:kCGBlendModeLighten alpha:1.0];
        
    // Drawing code
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *mytouch=[[touches allObjects] objectAtIndex:0];
    point = [mytouch locationInView:self];

}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *mytouch=[[touches allObjects] objectAtIndex:0];
    CGPoint here = [mytouch locationInView:self];
    int x,y;
    x= here.x;
    y=here.y;
    if (x<0){
        x=0;
    }else if (x>320){
        x=320;
    }
    if (y<174){
        y=174;
    }else if (y>416){
        y=416;
    }
     _myPath=[[UIBezierPath alloc] init];
    [_myPath moveToPoint:CGPointMake(x, 174)];
    [_myPath addLineToPoint:CGPointMake(x, 416)];
    _vertLine=[[UIBezierPath alloc] init];
    [_vertLine moveToPoint:CGPointMake(0,y)];
    [_vertLine addLineToPoint:CGPointMake(320, y)];
    contr=[[UIBezierPath alloc] init];
    test=[[UIBezierPath alloc] init];
    contr=[UIBezierPath bezierPathWithRect:CGRectMake(0,y,x , 416-y)];
    test=[UIBezierPath bezierPathWithRect:CGRectMake(x, y,320-x, 416-y)];
    if (x!=0 && x!=320 && y!=174){
     whiteBox=[[UIBezierPath alloc] init];
        whiteBox=[UIBezierPath bezierPathWithRect:CGRectMake(0, 174,320 ,y-174)];
    }else{
        whiteBox=[[UIBezierPath alloc] init];
    }
    
    [self setNeedsDisplay];
    
}
@end
