//
//  EarthquakeTableCell.h
//  What's Shaking, NZ?
//
//  Created by Adam Speakman on 4/05/13.
//  Copyright (c) 2013 Adam Speakman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EarthquakeTableCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *magnitudeLabel;
@property (nonatomic, weak) IBOutlet UILabel *locationLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@end
