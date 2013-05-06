//
//  DistanceTool.m
//  What's Shaking, NZ?
//
//  Created by Adam Speakman on 6/05/13.
//  Copyright (c) 2013 Adam Speakman. All rights reserved.
//

#import "DistanceTool.h"
#import <math.h>

@interface DistanceTool()
@property (nonatomic) NSDictionary *locations;
@end

@implementation DistanceTool

static NSDictionary *_locations;

+ (NSDictionary *) locations
{
    if (_locations.count > 0)
        return _locations;
    _locations = [[NSDictionary alloc] initWithObjectsAndKeys:
                  [[CLLocation alloc] initWithLatitude:-35.725156 longitude:174.323735], @"Whangarei",
                  [[CLLocation alloc] initWithLatitude:-36.848457 longitude:174.763351], @"Auckland",
                  [[CLLocation alloc] initWithLatitude:-37.687798 longitude:176.165149], @"Tauranga",
                  [[CLLocation alloc] initWithLatitude:-37.787009 longitude:175.279268], @"Hamilton",
                  [[CLLocation alloc] initWithLatitude:-37.953419 longitude:176.990813], @"Whakatane",
                  [[CLLocation alloc] initWithLatitude:-38.136875 longitude:176.249759], @"Rotorua",
                  [[CLLocation alloc] initWithLatitude:-38.662354 longitude:178.017648], @"Gisborne",
                  [[CLLocation alloc] initWithLatitude:-38.685686 longitude:176.070214], @"Taupo",
                  [[CLLocation alloc] initWithLatitude:-39.055622 longitude:174.075247], @"New Plymouth",
                  [[CLLocation alloc] initWithLatitude:-39.492839 longitude:176.912026], @"Napier",
                  [[CLLocation alloc] initWithLatitude:-39.639558 longitude:176.839247], @"Hastings",
                  [[CLLocation alloc] initWithLatitude:-39.930093 longitude:175.047932], @"Wanganui",
                  [[CLLocation alloc] initWithLatitude:-40.352309 longitude:175.608204], @"Palmerston North",
                  [[CLLocation alloc] initWithLatitude:-40.622243 longitude:175.286181], @"Levin",
                  [[CLLocation alloc] initWithLatitude:-40.951114 longitude:175.657356], @"Masterton",
                  [[CLLocation alloc] initWithLatitude:-41.124415 longitude:175.070785], @"Upper Hutt",
                  [[CLLocation alloc] initWithLatitude:-41.133935 longitude:174.840628], @"Porirua",
                  [[CLLocation alloc] initWithLatitude:-41.209163 longitude:174.90805], @"Lower Hutt",
                  [[CLLocation alloc] initWithLatitude:-41.28647 longitude:174.776231], @"Wellington",
                  [[CLLocation alloc] initWithLatitude:-41.270632 longitude:173.284049], @"Nelson",
                  [[CLLocation alloc] initWithLatitude:-41.513444 longitude:173.961261], @"Blenheim",
                  [[CLLocation alloc] initWithLatitude:-42.450398 longitude:171.210765], @"Greymouth",
                  [[CLLocation alloc] initWithLatitude:-43.532041 longitude:172.636268], @"Christchurch",
                  [[CLLocation alloc] initWithLatitude:-44.396999 longitude:171.255005], @"Timaru",
                  [[CLLocation alloc] initWithLatitude:-45.031176 longitude:168.662643], @"Queenstown",
                  [[CLLocation alloc] initWithLatitude:-45.878764 longitude:170.502812], @"Dunedin",
                  [[CLLocation alloc] initWithLatitude:-46.413177 longitude:168.35376], @"Invercargill", nil];
    return _locations;
}

// For calculating distance
static double RADIO = 6378.16; // Radius of the earth, in km

+ (double) radiansFromDegrees:(double) degrees
{
    return degrees * M_PI / 180.0;
}

+ (NSString *) directionFromLocation:(CLLocationCoordinate2D) closestTown toOtherLocation: (CLLocationCoordinate2D) quakeEpicenter
{
    double dLon = abs(quakeEpicenter.longitude - closestTown.longitude);
    double dLat = abs(quakeEpicenter.latitude - closestTown.latitude);
    double brng = atan(dLat / dLon);
    
    NSString *direction;
    NSString *eastOrWest;
    NSString *northOrSouth;
    
    // Quake is West of town
    if(quakeEpicenter.longitude < closestTown.longitude)
        eastOrWest = @"west";
    else // Quake is East of town
        eastOrWest = @"east";
    
    // Quake is North of town
    if(quakeEpicenter.latitude > closestTown.latitude)
        northOrSouth = @"north";
    else // Quake is South of town
        northOrSouth = @"south";
    
    if(brng < M_PI / 8)
        direction = eastOrWest;
    else if (brng < 3 * M_PI / 8)
        direction = [[northOrSouth stringByAppendingString: @"-"] stringByAppendingString: eastOrWest];
    else
        direction = northOrSouth;
    
    return direction;
}

/**
 Returns distance in kilometers between point1 and point2.
 As seen here: http://stackoverflow.com/questions/27928/how-do-i-calculate-distance-between-two-latitude-longitude-points
 Modified to suit Objective-C.
 */
+ (double) distanceInKilometersBetweenPlaceOne:(CLLocationCoordinate2D)placeOne andPlaceTwo:(CLLocationCoordinate2D)placeTwo
{
    double lon1 = placeOne.longitude;
    double lat1 = placeOne.latitude;
    double lon2 = placeTwo.longitude;
    double lat2 = placeTwo.latitude;
    double dlon = [DistanceTool radiansFromDegrees:(lon2 - lon1)];
    double dlat = [DistanceTool radiansFromDegrees:(lat2 - lat1)];
    
    double a = (sin(dlat / 2) * sin(dlat / 2))
    + cos([DistanceTool radiansFromDegrees:lat1]) * cos([DistanceTool radiansFromDegrees:lat2])
    * (sin(dlon / 2) * sin(dlon / 2));
    double angle = 2 * atan2(sqrt(a), sqrt(1 - a));
    return angle * RADIO;
}

+ (NSString *) closestTownToCoordinate:(CLLocationCoordinate2D)placeOne
{
    // Find the distance from the closest town
    double closestTownDistance = -1;
    NSString *closestTownName = nil;
    CLLocationCoordinate2D closestTown;
    for(NSString *location in [[DistanceTool locations] keyEnumerator])
    {
        CLLocationCoordinate2D placeTwo = [(CLLocation *)[[DistanceTool locations] objectForKey:location] coordinate];
        if(closestTownDistance < 0)
        {
            closestTown = placeTwo;
            closestTownName = location;
            closestTownDistance = [DistanceTool distanceInKilometersBetweenPlaceOne: placeOne andPlaceTwo:placeTwo];

        }
        else
        {
            double distance = [DistanceTool distanceInKilometersBetweenPlaceOne: placeOne andPlaceTwo:placeTwo];
            if(distance < closestTownDistance)
            {
                closestTown = placeTwo;
                closestTownName = location;
                closestTownDistance = distance;
            }
        }
    }
    
    // Find direction from the closest town
    NSString *direction = [DistanceTool directionFromLocation: closestTown toOtherLocation: placeOne];
    
    // TODO Figure out how to localise this/extract it into strings.xml.
    // The problem is, we don't have access to getString() to fetch from strings.xml
    return [NSString stringWithFormat:@"%.0f km %@ of %@", closestTownDistance, direction, closestTownName];}
@end
