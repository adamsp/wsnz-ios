//
//  WSNZEarthquakeDetailViewController.m
//  What's Shaking, NZ?
//
//  Created by Adam Speakman on 28/04/13.
//  Copyright (c) 2013 Adam Speakman. All rights reserved.
//

#import "WSNZEarthquakeDetailViewController.h"

@interface WSNZEarthquakeDetailViewController ()

@end

@implementation WSNZEarthquakeDetailViewController
static const int MAGNITUDE_TAG = 1;
static const int DEPTH_TAG = 2;
static const int DATE_TAG = 3;
static const int STATUS_TAG = 4;

@synthesize quake;

// TODO This exists here and in the map VC.
static NSString *reuseId = @"pin";

- (void)viewDidLoad
{
    [super viewDidLoad];
    UILabel *label = (UILabel *)[self.view viewWithTag:MAGNITUDE_TAG];
    label.text = self.quake.formattedMagnitude;
    label = (UILabel *)[self.view viewWithTag:DEPTH_TAG];
    label.text = self.quake.formattedDepth;
    label = (UILabel *)[self.view viewWithTag:DATE_TAG];
    label.text = self.quake.formattedDate;
    label = (UILabel *)[self.view viewWithTag:STATUS_TAG];
    label.text = self.quake.status;
    
    [self.mapView addAnnotation:[self.quake makeMKAnnotationForIndex:0]];
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.quake.coordinate, 120000, 120000);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation
{
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseId];
    
    if (annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseId];
        annotationView.canShowCallout = YES;
    } else {
        annotationView.annotation = annotation;
    }
    annotationView.pinColor = self.quake.pinColor;
    
    return annotationView;
}

@end
