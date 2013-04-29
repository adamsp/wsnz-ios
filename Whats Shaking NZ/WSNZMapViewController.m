//
//  WSNZMapViewController.m
//  What's Shaking, NZ?
//
//  Created by Adam Speakman on 29/04/13.
//  Copyright (c) 2013 Adam Speakman. All rights reserved.
//

#import "WSNZMapViewController.h"

@interface WSNZMapViewController ()

@end

@implementation WSNZMapViewController
@synthesize model = _model;

static double NZ_CENTRE_LATITUDE = -41;
static double NZ_CENTRE_LONGITUDE = 173;

- (WSNZEarthquakeModel*) model {
    if (!_model)
    {
        _model = [WSNZEarthquakeModel instance];
        [_model addUpdateListener:self];
    }
    return _model;
}

- (IBAction)refreshPressed:(id)sender
{
    [self.model requestUpdate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.model = [WSNZEarthquakeModel instance];
    [self.model addUpdateListener:self];
    [self earthquakesUpdated];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - EarthquakesUpdatedDelegate

- (void) earthquakesUpdated
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(NZ_CENTRE_LATITUDE, NZ_CENTRE_LONGITUDE), 1200000, 120000);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    for (Earthquake *quake in self.model.quakes) {
        [self.mapView addAnnotation:quake.makeMKAnnotation];
    }
}

@end
