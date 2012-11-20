//
//  mainView.h
//  Pesticheck
//
//  Created by Chad Glen on 12-07-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
/*
 The start up page where the analysis is actually completed
 */
#import <UIKit/UIKit.h>

#import "PestStrip.h"
#import "tableView.h"
#import "lineSplit.h"

#import <CoreLocation/CoreLocation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "Pixel.h"
@interface mainView : UIViewController <CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
    UIImagePickerController *UIPicker;
    CLLocationManager *locationManager;
    UIActivityIndicatorView *activ;
}
- (IBAction)toComments:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *tapResults;
@property (weak, nonatomic) IBOutlet UIImageView *check1;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UIImageView *sImage;
@property (strong) lineSplit *line;
- (IBAction)imgSelect:(id)sender;
- (IBAction)startAnalysis:(id)sender;
- (IBAction)takePic:(id)sender;

@property (nonatomic, retain) CLLocationManager *locationManager;

@property (weak, nonatomic) IBOutlet UILabel *testLab;
@property (weak, nonatomic) IBOutlet UILabel *controlLab;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *startText;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *arrowImgs;



@end
