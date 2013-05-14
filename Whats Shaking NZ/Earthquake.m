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
@synthesize shouldHighlight;

static NSDateFormatter* _dateFormatter;
+(NSDateFormatter *) dateFormatter
{
    if(_dateFormatter == nil)
    {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
        [_dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    }
    return _dateFormatter;
}

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
    _formattedDate = [Earthquake.dateFormatter stringFromDate:date];
}

-(NSString *)formattedDate {
    return _formattedDate;
}

-(CLLocationCoordinate2D)coordinate
{
    return CLLocationCoordinate2DMake(self.latitude.doubleValue, self.longitude.doubleValue);
}

-(bool) shouldHighlight
{
    return self.magnitude.doubleValue >= [[NSUserDefaults standardUserDefaults] doubleForKey:@"notification_magnitude"];
}

-(MKPinAnnotationColor)pinColor
{
    if(self.shouldHighlight) {
        return MKPinAnnotationColorRed;
    } else {
        return MKPinAnnotationColorGreen;
    }
}

-(EarthquakeAnnotation *) makeMKAnnotationForIndex:(NSInteger)index
{
    EarthquakeAnnotation *annotation = [[EarthquakeAnnotation alloc] initWithCoordinate:self.coordinate title:self.formattedMagnitude subTitle:self.formattedDepth index:index];
    return annotation;
}

@end
