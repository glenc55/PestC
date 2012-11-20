//
//  PestStrip.h
//  Pesticheck
//
//  Created by Chad Glen on 12-10-28.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
/*
 NSCoreData subobject for storing all the data
 */
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PestStrip : NSManagedObject

@property (nonatomic, retain) NSNumber * blueC;
@property (nonatomic, retain) NSNumber * blueT;
@property (nonatomic, retain) NSString * comments;
@property (nonatomic, retain) NSNumber * control;
@property (nonatomic, retain) NSDate * dateAdded;
@property (nonatomic, retain) NSNumber * greenC;
@property (nonatomic, retain) NSNumber * greenT;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSNumber * redC;
@property (nonatomic, retain) NSNumber * redT;
@property (nonatomic, retain) NSNumber * sent;
@property (nonatomic, retain) NSNumber * test;

@end
