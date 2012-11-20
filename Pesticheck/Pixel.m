//
//  Pixel.m
//  newPixelBreakdown
//
//  Created by Chad Glen on 12-10-29.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Pixel.h"

@implementation Pixel
@synthesize red=_red;
@synthesize green=_green;
@synthesize blue=_blue;
@synthesize alpha=_alpha;

-(void) withRed:(CGFloat)red withGreen:(CGFloat)green withBlue:(CGFloat)blue andAlpha:(CGFloat)alpha{
    _red=red;
    _green=green;
    _blue=blue;
    _alpha=alpha;
    
}

@end
