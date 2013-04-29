//
//  WSNZEarthquakeDetailViewController.h
//  What's Shaking, NZ?
//
//  Created by Adam Speakman on 28/04/13.
//  Copyright (c) 2013 Adam Speakman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Earthquake.h"

@interface WSNZEarthquakeDetailViewController : UIViewController <MKMapViewDelegate>
@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) Earthquake *quake;
@end
