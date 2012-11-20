//
//  locationTable.h
//  Pesticheck
//
//  Created by Chad Glen on 12-08-02.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"
#import <CoreLocation/CoreLocation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "mapView.h"

@interface locationTable : UITableViewController <CLLocationManagerDelegate> {
      CLLocationManager *locationManager;
}
- (IBAction)dismissTable:(id)sender;
- (IBAction)addLocation:(id)sender;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic,retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@end
