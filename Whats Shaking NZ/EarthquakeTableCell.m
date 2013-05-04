//
//  EarthquakeTableCell.m
//  What's Shaking, NZ?
//
//  Created by Adam Speakman on 4/05/13.
//  Copyright (c) 2013 Adam Speakman. All rights reserved.
//

#import "EarthquakeTableCell.h"

@implementation EarthquakeTableCell
@synthesize magnitudeLabel = _magnitudeLabel;
@synthesize locationLabel = _locationLabel;
@synthesize dateLabel = _dateLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
