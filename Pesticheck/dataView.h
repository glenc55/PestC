//
//  dataView.h
//  Pesticheck
//
//  Created by Chad Glen on 12-07-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
/*
shows the detailed results if a cell in tableView was selected
 */
#import <UIKit/UIKit.h>
#import "PestStrip.h"
#import <QuartzCore/QuartzCore.h>
@class PestStrip;

@interface dataView : UIViewController<UIAlertViewDelegate,UITextViewDelegate>{
    PestStrip *pestStrip;
    UITextField *textField;
    NSString *email;
}

- (IBAction)dismissKeyboard:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *pLab;

@property (weak, nonatomic) IBOutlet UILabel *rgbLab;
@property (weak, nonatomic) IBOutlet UITextView *addComments;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;
- (IBAction)sendDataToWebsite:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *savedImage;
- (IBAction)openMenu:(id)sender;

- (IBAction)toMap:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *labG;


@property (nonatomic, retain) PestStrip *pestStrip;

- (IBAction)dismissData:(id)sender;
@property (nonatomic,strong) NSManagedObjectContext *managedObjectContext;
@end
