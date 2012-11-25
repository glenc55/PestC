//
//  DisplayMap.h
//  Image Analysis
//
//  Created by Chad Glen on 12-06-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
/*
 Map annotation objects 
 */
#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>


@interface DisplayMap : NSObject <MKAnnotation> {

	CLLocationCoordinate2D coordinate; 
	NSString *title; 
	NSString *subtitle;
}
@property (nonatomic, assign) CLLocationCoordinate2D coordinate; 
@property (nonatomic, copy) NSString *title; 
@property (nonatomic, copy) NSString *subtitle;

@end
