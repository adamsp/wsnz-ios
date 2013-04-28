//
//  WSNZEarthquakeListViewController.h
//  What's Shaking, NZ?
//
//  Created by Adam Speakman on 25/04/13.
//  Copyright (c) 2013 Adam Speakman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EarthquakesUpdatedDelegate.h"
#import "WSNZEarthquakeModel.h"
#import "WSNZEarthquakeDetailViewController.h"

@interface WSNZEarthquakeListViewController : UITableViewController <EarthquakesUpdatedDelegate>
@property (nonatomic, strong) WSNZEarthquakeModel* model;
@end
