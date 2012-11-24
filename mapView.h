//
//  mapView.h
//  Image Analysis
//
//  Created by Chad Glen on 12-06-18.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
/*
viewcontroller for viewing location where strip was analyzed 
 */
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface mapView : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>{
    IBOutlet MKMapView *mapViewer;
    NSString *title;
}
@property (weak, nonatomic) IBOutlet UINavigationItem *mapTitle;
@property (nonatomic) NSString *title;
@property (nonatomic) CLLocation *location;
@property (nonatomic, weak) NSNumber *lat;
@property (nonatomic, weak) NSNumber *lon;
@property (weak, nonatomic) IBOutlet UILabel *latitude;
@property (weak, nonatomic) IBOutlet UILabel *longitude;
@property (nonatomic, retain) MKMapView *mapViewer;
- (IBAction)dismissMap:(id)sender;

@end
