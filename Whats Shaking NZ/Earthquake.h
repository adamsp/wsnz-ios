//
//  Earthquake.h
//  What's Shaking, NZ?
//
//  Created by Adam Speakman on 25/04/13.
//  Copyright (c) 2013 Adam Speakman. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <stdlib.h>

@interface Earthquake : NSObject
@property (nonatomic, retain) NSNumber* longitude;
@property (nonatomic, retain) NSNumber* latitude;
@property (nonatomic, retain) NSNumber* depth;
@property (nonatomic, retain) NSNumber* magnitude;
@property (nonatomic, retain) NSString* reference;
@property (nonatomic, retain) NSString* agency;
@property (nonatomic, retain) NSDate* date;
@property (nonatomic, retain) NSString* status;
@end
