//
//  EarthquakeAnnotation.m
//  What's Shaking, NZ?
//
//  Created by Adam Speakman on 4/05/13.
//  Copyright (c) 2013 Adam Speakman. All rights reserved.
//

#import "EarthquakeAnnotation.h"

@implementation EarthquakeAnnotation
@synthesize coordinate;
@synthesize index;

- (NSString *)subtitle{
    return mSubTitle;
}

- (NSString *)title{
    return mTitle;
}

-(id)initWithCoordinate:(CLLocationCoordinate2D) c title: (NSString *)title subTitle: (NSString *) subTitle index: (NSInteger) i{
    coordinate = c;
    index = i;
    mTitle = title;
    mSubTitle = subTitle;
    return self;
}

@end
