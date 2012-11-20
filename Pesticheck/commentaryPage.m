//
//  commentaryPage.m
//  Pesticheck
//
//  Created by Chad Glen on 12-10-07.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "commentaryPage.h"

@interface commentaryPage ()

@end

@implementation commentaryPage
@synthesize paperBut;
@synthesize comText;
@synthesize affiliationText;
@synthesize nameText;
@synthesize gpsSwitch;
@synthesize buttontoSplit;
CGFloat animatedDistance;
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    comText.delegate=self;
    splitTextBox *newView = [[splitTextBox alloc] initWithFrame:CGRectMake(15, 13,290,280)];
    [self.view insertSubview:newView aboveSubview:buttontoSplit];
    
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setButtontoSplit:nil];

    [self setPaperBut:nil];
    [self setGpsSwitch:nil];
    [self setNameText:nil];
    [self setAffiliationText:nil];
    [self setComText:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
-(void) textViewDidBeginEditing:(UITextView *)textView{
    CGRect textViewRect =
    [self.view.window convertRect:textView.bounds fromView:textView];
    CGRect viewRect =
    [self.view.window convertRect:self.view.bounds fromView:self.view];
    CGFloat midline = textViewRect.origin.y + 0.5 * textViewRect.size.height;
    CGFloat numerator =
    midline - viewRect.origin.y
    - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator =
    (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)
    * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)readPaper:(id)sender {
    if ( [paperBut.titleLabel.text isEqualToString:@"Yes"]){
        [paperBut setTitle:@"No" forState:UIControlStateNormal];
    } else{
      [paperBut setTitle:@"Yes" forState:UIControlStateNormal];   
    }
}
- (IBAction)sendComments:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)dismissKeyboard:(id)sender {
    [comText resignFirstResponder];
    [affiliationText resignFirstResponder];
    [nameText resignFirstResponder];
}
@end
