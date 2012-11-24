//
//  mapView.m
//  Image Analysis
//
//  Created by Chad Glen on 12-06-18.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "mapView.h"
#import "DisplayMap.h"
@interface mapView ()

@end

@implementation mapView
@synthesize latitude;
@synthesize longitude;
@synthesize mapViewer;
@synthesize lat, lon;
@synthesize location;
@synthesize mapTitle;
@synthesize title;
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
    mapTitle.title=title;
    double x =[lat doubleValue];
    double y =[lon doubleValue];
    latitude.text = [lat stringValue];
    longitude.text =[lon stringValue];
    
    [mapViewer setMapType:MKMapTypeStandard];
    [mapViewer setZoomEnabled:YES];
	[mapViewer setScrollEnabled:YES];
    
	MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } }; 
	region.center.latitude = x ;
	region.center.longitude = y;
    //region.center.latitude = 43.26 ;
	//region.center.longitude = -79.9;
	region.span.longitudeDelta = 0.01f;
	region.span.latitudeDelta = 0.01f;
	[mapViewer setRegion:region animated:YES]; 
	[mapViewer setDelegate:self];

    DisplayMap *ann = [[DisplayMap alloc] init]; 
	ann.title = @"Marked Location";
	ann.subtitle = title; 
	ann.coordinate = region.center; 
	[mapViewer addAnnotation:ann];

    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:
(id <MKAnnotation>)annotation {
	MKPinAnnotationView *pinView = nil; 
	if(annotation != mapViewer.userLocation) 
	{
		static NSString *defaultPinID = @"pin";
		pinView = (MKPinAnnotationView *)[mapViewer dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
		if ( pinView == nil ) pinView = [[MKPinAnnotationView alloc]
										  initWithAnnotation:annotation reuseIdentifier:defaultPinID] ;
        
		pinView.pinColor = MKPinAnnotationColorRed; 
		pinView.canShowCallout = YES;
		pinView.animatesDrop = YES;
    } 
	else {
		[mapViewer.userLocation setTitle:@"Current Location"];
	}
	return pinView;
}

- (void)viewDidUnload
{
   
    [self setMapTitle:nil];
    [self setLatitude:nil];
    [self setLongitude:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)dismissMap:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
@end
