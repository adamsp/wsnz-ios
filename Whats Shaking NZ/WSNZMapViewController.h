//
//  WSNZMapViewController.h
//  What's Shaking, NZ?
//
//  Created by Adam Speakman on 29/04/13.
//  Copyright (c) 2013 Adam Speakman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "WSNZEarthquakeModel.h"
#import "EarthquakesUpdatedDelegate.h"
#import "EarthquakeAnnotation.h"
#import "WSNZEarthquakeDetailViewController.h"

@interface WSNZMapViewController : UIViewController <MKMapViewDelegate, EarthquakesUpdatedDelegate>
@property (nonatomic, strong) WSNZEarthquakeModel* model;
@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@end
