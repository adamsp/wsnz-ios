//
//  WSNZEarthquakeModel.h
//  What's Shaking, NZ?
//
//  Created by Adam Speakman on 25/04/13.
//  Copyright (c) 2013 Adam Speakman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EarthquakesUpdatedDelegate.h"
#import "Earthquake.h"

@interface WSNZEarthquakeModel : NSObject <NSURLConnectionDataDelegate>
+ (id) instance;
- (void) requestUpdate;
- (void) addUpdateListener:(id <EarthquakesUpdatedDelegate>) listener;
@property (nonatomic) NSArray * quakes;
@end
