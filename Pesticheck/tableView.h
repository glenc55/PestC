//
//  tableView.h
//  Pesticheck
//
//  Created by Chad Glen on 12-07-18.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
/*
 table of all data stored in coredata database of peststrip objects
 */

#import <UIKit/UIKit.h>
#import "PestStrip.h"
#import "mainView.h"
#import "dataView.h"

@interface tableView : UITableViewController<NSFetchedResultsControllerDelegate>
@property (nonatomic,retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@end

