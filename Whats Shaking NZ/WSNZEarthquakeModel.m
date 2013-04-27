//
//  WSNZEarthquakeModel.m
//  What's Shaking, NZ?
//
//  Created by Adam Speakman on 25/04/13.
//  Copyright (c) 2013 Adam Speakman. All rights reserved.
//

#import "WSNZEarthquakeModel.h"

@interface WSNZEarthquakeModel ()
- (void) notifyListeners;
@property (nonatomic) NSMutableArray *listeners;
@property (nonatomic) NSMutableData *receivedData;
@end


@implementation WSNZEarthquakeModel

@synthesize listeners = _listeners;
@synthesize receivedData;

@synthesize quakes;


#pragma mark Singleton
static WSNZEarthquakeModel *instance = nil;
static bool downloading = false;

+ (WSNZEarthquakeModel *) instance {
    if (instance == nil) {
        instance = [[super allocWithZone:NULL] init];
        instance.listeners = [[NSMutableArray alloc] init];
    }
    return instance;
}

+ (id) allocWithZone:(NSZone *)zone {
    return [self instance];
}

- (id) copy {
    return self;
}

- (void) requestUpdate {
    if (downloading) return;
    
    downloading = true;
    
    // Initialise new data
    NSMutableData *data = [[NSMutableData alloc] init];
    self.receivedData = data;
    
    NSURL *url = [[NSURL alloc] initWithString:@"http://geonet.org.nz/quakes/services/felt.json"];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    [connection start];
}

- (void) addUpdateListener:(id <EarthquakesUpdatedDelegate>) listener {
    [self.listeners addObject:listener];
}

- (void) notifyListeners
{
    for (id <EarthquakesUpdatedDelegate> listener in self.listeners)
    {
        [listener earthquakesUpdated];
    }
}

# pragma mark NSURLConnectionDataDelegate

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // TODO Handle errors.
    downloading = false;    
}

//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
//{
//
//}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSMutableArray *parsedQuakes = [[NSMutableArray alloc] initWithCapacity:30];
    NSError *errorInfo;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:self.receivedData options:kNilOptions error:&errorInfo];
    NSArray *features = [json objectForKey:@"features"];
    for (NSDictionary *feature in features) {
        Earthquake *quake = [[Earthquake alloc] init];
        NSArray *coords = [feature objectForKey:@"coordinates"];
        quake.longitude = [coords objectAtIndex:0];
        quake.latitude = [coords objectAtIndex:1];
        NSDictionary *properties = [feature objectForKey:@"properties"];
        quake.depth = [properties objectForKey:@"depth"];
        quake.magnitude = [properties objectForKey:@"magnitude"];
        quake.reference = [properties objectForKey:@"publicid"];
        quake.agency = [properties objectForKey:@"agency"];
        quake.date = [properties objectForKey:@"origintime"];
        quake.status = [properties objectForKey:@"status"];
        [parsedQuakes addObject:quake];
    }
    self.quakes = parsedQuakes; // = parsed quakes...
    [self notifyListeners];
    downloading = false;
}

@end
