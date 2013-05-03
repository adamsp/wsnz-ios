//
//  EarthquakeAnnotation.h
//  What's Shaking, NZ?
//
//  Created by Adam Speakman on 4/05/13.
//  Copyright (c) 2013 Adam Speakman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface EarthquakeAnnotation : NSObject<MKAnnotation> {
    CLLocationCoordinate2D coordinate;
    NSString *mTitle;
    NSString *mSubTitle;
}
@property NSInteger index;
-(id)initWithCoordinate:(CLLocationCoordinate2D) c title: (NSString *)title subTitle: (NSString *) subTitle index: (int)index;
@end
