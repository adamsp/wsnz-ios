//
//  DistanceTool.h
//  What's Shaking, NZ?
//
//  Created by Adam Speakman on 6/05/13.
//  Copyright (c) 2013 Adam Speakman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface DistanceTool : NSObject
+ (double) distanceInKilometersBetweenPlaceOne:(CLLocationCoordinate2D) placeOne andPlaceTwo:(CLLocationCoordinate2D) placeTwo;
+ (NSString *) closestTownToCoordinate:(CLLocationCoordinate2D) coordinate;
@end
