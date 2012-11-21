//
//  lineSplit.h
//  photoSplit
//
//  Created by Chad Glen on 12-07-24.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
/*
 Creates image crop boundaries before analysis one horizontal and one vertical line
 */
#import <UIKit/UIKit.h>

@interface lineSplit : UIView{
    CGPoint point;
    NSAttributedString * currentText;
}
@property (strong) UIBezierPath *whiteBox;
@property (strong) UIBezierPath *myPath;
@property (strong) UIBezierPath *vertLine;
@property (strong) UIBezierPath *contr;
@property (strong) UIBezierPath *test;

@end
