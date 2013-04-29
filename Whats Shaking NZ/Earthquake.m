//
//  Earthquake.m
//  What's Shaking, NZ?
//
//  Created by Adam Speakman on 25/04/13.
//  Copyright (c) 2013 Adam Speakman. All rights reserved.
//

#import "Earthquake.h"

@implementation Earthquake
@synthesize longitude;
@synthesize latitude;
@synthesize reference;
@synthesize agency;
@synthesize status;

-(void) setDepth:(NSNumber *)depth {
    _depth = depth;
    _formattedDepth = [NSString stringWithFormat:@"%d km", [depth intValue]];
}

-(NSString *)formattedDepth {
    return _formattedDepth;
}

-(void) setMagnitude:(NSNumber *)magnitude {
    _magnitude = magnitude;
    _formattedMagnitude = [NSString stringWithFormat:@"%.1f", [magnitude doubleValue]];
}

-(NSString *)formattedMagnitude {
    return _formattedMagnitude;
}

-(void) setDate:(NSDate *)date {
    _date = date;
    // TODO Use NSDateFormatter
    _formattedDate = [date description];
}

-(NSString *)formattedDate {
    return _formattedDate;
}

-(CLLocationCoordinate2D)coordinate
{
    return CLLocationCoordinate2DMake(self.latitude.doubleValue, self.longitude.doubleValue);
}

-(id <MKAnnotation>) makeMKAnnotation
{
    MKPointAnnotation *pin = [[MKPointAnnotation alloc] init];
    pin.coordinate = self.coordinate;
    pin.title = self.formattedMagnitude;
    pin.subtitle = self.formattedDepth;
    return pin;
}
@end
