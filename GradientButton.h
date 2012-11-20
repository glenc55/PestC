//
//  GradientButton.h
//  GradientButton
//
//  Created by Chad Glen on 12-06-08.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface GradientButton : UIButton {
    CAGradientLayer *shineLayer;
    CALayer         *highlightLayer;
}
@end
