//
//  WSNZEarthquakeListViewController.m
//  What's Shaking, NZ?
//
//  Created by Adam Speakman on 25/04/13.
//  Copyright (c) 2013 Adam Speakman. All rights reserved.
//

#import "WSNZEarthquakeListViewController.h"
#import "Earthquake.h"

@interface WSNZEarthquakeListViewController ()

@end

@implementation WSNZEarthquakeListViewController

@synthesize model = _model;

static NSString *segueId = @"showDetail";
static NSString *cellId = @"quakeDetailCell";

- (WSNZEarthquakeModel*) model {
    if (!_model)
    {
        _model = [WSNZEarthquakeModel instance];
        [_model addUpdateListener:self];
    }
    return _model;
}

- (IBAction)refreshPressed:(id)sender
{
    [self.model requestUpdate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.model = [WSNZEarthquakeModel instance];
    [self.model addUpdateListener:self];
    [self.model requestUpdate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // TODO Display a spinner when quakes are empty?...
    // Return the number of rows in the section.
    return [[self.model quakes] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EarthquakeTableCell *cell = (EarthquakeTableCell *)[tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    Earthquake *earthquake = [[self.model quakes] objectAtIndex:indexPath.row];
    
    cell.magnitudeLabel.text = earthquake.formattedMagnitude;
    if (earthquake.shouldHighlight) {
        [cell.magnitudeLabel setTextColor:[UIColor highlightColorForList]];
    } else {
        [cell.magnitudeLabel setTextColor:[UIColor standardColorForList]];
    }
    cell.locationLabel.text = [DistanceTool closestTownToCoordinate:earthquake.coordinate];
    cell.dateLabel.text = earthquake.formattedDate;
    
    return cell;
}

#pragma mark - EarthquakesUpdatedDelegate

- (void) earthquakesUpdated
{
    [self.tableView reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:segueId]){
        WSNZEarthquakeDetailViewController *controller = (WSNZEarthquakeDetailViewController *)segue.destinationViewController;
        controller.quake = [self.model.quakes objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    }
}

@end

