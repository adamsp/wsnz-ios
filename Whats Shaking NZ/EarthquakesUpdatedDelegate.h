//
//  EarthquakesUpdatedDelegate.h
//  What's Shaking, NZ?
//
//  Created by Adam Speakman on 25/04/13.
//  Copyright (c) 2013 Adam Speakman. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EarthquakesUpdatedDelegate <NSObject>
@required
- (void) earthquakesUpdated;

@end
