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

static NSString *reuseId = @"mapViewPin";
static NSString *segueId = @"showDetail";

int selectedIndex;

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
    
    // Clear all annotations first.
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    NSInteger index = 0;
    for (Earthquake *quake in self.model.quakes) {
        [self.mapView addAnnotation:[quake makeMKAnnotationForIndex:index]];
        index++;
    }
}

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation
{
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseId];
    
    if (annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseId];
        annotationView.canShowCallout = YES;
    } else {
        annotationView.annotation = annotation;
    }
    
    EarthquakeAnnotation *quakeAnnotation = (EarthquakeAnnotation *)annotation;
    Earthquake *quake = self.model.quakes[quakeAnnotation.index];
    annotationView.pinColor = quake.pinColor;
    
    UIButton *detailButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    detailButton.tag = quakeAnnotation.index;
    [detailButton addTarget:self action:@selector(showDetailView:) forControlEvents:UIControlEventTouchUpInside];
    annotationView.rightCalloutAccessoryView = detailButton;

    return annotationView;
}

-(void)showDetailView:(id)sender{
    selectedIndex = ((UIButton *)sender).tag;
    [self performSegueWithIdentifier: segueId sender: self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString: segueId]){
        WSNZEarthquakeDetailViewController *controller = (WSNZEarthquakeDetailViewController *)segue.destinationViewController;
        controller.quake = [self.model.quakes objectAtIndex:selectedIndex];
    }
}

@end
