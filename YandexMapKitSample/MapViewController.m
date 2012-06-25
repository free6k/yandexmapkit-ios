/*
 * MapViewController.m
 *
 * This file is a part of the Yandex Map Kit.
 *
 * Version for iOS © 2011 YANDEX
 * 
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at http://legal.yandex.ru/mapkit/
 */

#import "MapViewController.h"
#import "Settings.h"

@interface MapViewController ()

- (void)configureAndInstallMapView;

@end


@implementation MapViewController

#pragma mark - View lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:@"MapViewController" bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureAndInstallMapView];
}

- (void)viewDidUnload {
    self.mapView = nil;

    [super viewDidUnload];
}

#pragma mark - Helpers

- (void)configureAndInstallMapView {
    NSString *apiKey = [Settings sharedSettings].apiKey;
    
    if (![apiKey length]) {
        // Replace with your own Yandex Map Kit API key
        apiKey = nil;
    }
    self.mapView.apiKey = apiKey;
}

#pragma mark - Properties

@synthesize mapView;

#pragma mark - Memory Management

- (void)dealloc {
    self.mapView.delegate = nil;
    self.mapView = nil;

    [super dealloc];
}

@end
