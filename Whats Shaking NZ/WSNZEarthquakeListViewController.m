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
    static NSString *CellIdentifier = @"Earthquake Description";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // TODO Should be using a custom view
    Earthquake *earthquake = [[self.model quakes] objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%.1f", [earthquake.magnitude doubleValue]];
    // TODO Should be using NSDateFormatter
    cell.detailTextLabel.text = [earthquake.date description];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

#pragma mark - EarthquakesUpdatedDelegate

- (void) earthquakesUpdated
{
    [self.tableView reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showDetail"]){
        WSNZEarthquakeDetailViewController *controller = (WSNZEarthquakeDetailViewController *)segue.destinationViewController;
        controller.quake = [self.model.quakes objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    }
}

@end

