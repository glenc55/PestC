//
//  Pixel.h
//  newPixelBreakdown
//
//  Created by Chad Glen on 12-10-29.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
/*
 pixel object to hold RGB data
 */
#import <Foundation/Foundation.h>

@interface Pixel : NSObject
@property CGFloat red; 
@property CGFloat green; 
@property CGFloat blue; 
@property CGFloat alpha; 

-(void)withRed:(CGFloat)red withGreen:(CGFloat)green withBlue:(CGFloat)blue andAlpha:(CGFloat) alpha;

@end
