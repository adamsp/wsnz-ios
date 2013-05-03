//
//  Earthquake.h
//  What's Shaking, NZ?
//
//  Created by Adam Speakman on 25/04/13.
//  Copyright (c) 2013 Adam Speakman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#include <stdlib.h>
#include "EarthquakeAnnotation.h"

@interface Earthquake : NSObject
@property (nonatomic, retain) NSNumber* longitude;
@property (nonatomic, retain) NSNumber* latitude;
@property (nonatomic, retain) NSNumber* depth;
@property (nonatomic, retain) NSString* formattedDepth;
@property (nonatomic, retain) NSNumber* magnitude;
@property (nonatomic, retain) NSString* formattedMagnitude;
@property (nonatomic, retain) NSString* reference;
@property (nonatomic, retain) NSString* agency;
@property (nonatomic, retain) NSDate* date;
@property (nonatomic, retain) NSString* formattedDate;
@property (nonatomic, retain) NSString* status;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic) MKPinAnnotationColor pinColor;
-(EarthquakeAnnotation *) makeMKAnnotationForIndex:(NSInteger) index;
@end
