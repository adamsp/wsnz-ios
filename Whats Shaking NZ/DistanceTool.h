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
- (NSString *) closestTownToCoordinate:(CLLocationCoordinate2D) coordinate;
@end
