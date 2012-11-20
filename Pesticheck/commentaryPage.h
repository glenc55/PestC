//
//  commentaryPage.h
//  Pesticheck
//
//  Created by Chad Glen on 12-10-07.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
/*
 Not used at the moment, for later implementation to allow comments for whether the user had read the publication pertaining to this application
 */
#import <UIKit/UIKit.h>
#import "splitTextBox.h"

@interface commentaryPage : UIViewController<UITextViewDelegate>{
  
    
}
@property (weak, nonatomic) IBOutlet UITextView *comText;
@property (weak, nonatomic) IBOutlet UITextField *affiliationText;
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UISwitch *gpsSwitch;
@property (weak, nonatomic) IBOutlet UIButton *buttontoSplit;
- (IBAction)readPaper:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *paperBut;
- (IBAction)sendComments:(id)sender;
- (IBAction)dismissKeyboard:(id)sender;

@end
