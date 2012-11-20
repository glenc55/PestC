//
//  Location.h
//  Pesticheck
//
//  Created by Chad Glen on 12-08-02.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Location : NSManagedObject

@property (nonatomic, retain) NSNumber * lat;
@property (nonatomic, retain) NSNumber * longit;
@property (nonatomic, retain) NSDate * dateAdded;

@end
