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

@synthesize quake = _quake;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UILabel *label = (UILabel *)[self.view viewWithTag:MAGNITUDE_TAG];
    label.text = [NSString stringWithFormat:@"%.1f", [self.quake.magnitude doubleValue]];
    label = (UILabel *)[self.view viewWithTag:DEPTH_TAG];
    label.text = [NSString stringWithFormat:@"%d km", [self.quake.depth intValue]];
    label = (UILabel *)[self.view viewWithTag:DATE_TAG];
    // TODO Should be using NSDateFormatter
    label.text = [self.quake.date description];
    label = (UILabel *)[self.view viewWithTag:STATUS_TAG];
    label.text = self.quake.status;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
