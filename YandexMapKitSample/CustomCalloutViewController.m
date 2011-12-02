//
//  CustomCalloutViewController.m
//  YandexMapKitSample
//
//  Created by Roman Busyghin on 9/18/11.
//  Copyright 2011 Яндекс. All rights reserved.
//

#import "CustomCalloutViewController.h"
#import "CalloutView.h"

@interface CustomCalloutViewController ()

- (void)configureMapView;
- (void)configureAndInstallAnnotations;
- (void)configureAnnotationView:(YMKPinAnnotationView *)view forAnnotation:(id<YMKAnnotation>)annotation;

@property (nonatomic, retain) PointAnnotation * annotation;

@end


@implementation CustomCalloutViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureMapView];
    [self configureAndInstallAnnotations];
}

- (void)viewDidUnload {
    self.annotation = nil;

    [super viewDidUnload];
}

#pragma mark - YMKMapViewDelegate

- (YMKAnnotationView *)mapView:(YMKMapView *)mapView viewForAnnotation:(id<YMKAnnotation>)annotation
{
    static NSString * identifier = @"pointAnnotation";
    YMKPinAnnotationView * view = (YMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (view == nil) {
        view = [[[YMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier] autorelease];
        view.canShowCallout = YES;        
    }
    
    [self configureAnnotationView:view forAnnotation:annotation];
    
    return view;
}

#pragma mark - Helpers

- (void)configureMapView {
    self.mapView.showsUserLocation = NO;
    self.mapView.zoomButtons.hidden = YES;
    self.mapView.showTraffic = NO;
    [self.mapView setCenterCoordinate:YMKMapCoordinateMake(55.755816, 37.623507)
                          atZoomLevel:11
                             animated:NO];
}

- (void)configureAndInstallAnnotations {
    self.annotation = [PointAnnotation pointAnnotation];
    self.annotation.coordinate = YMKMapCoordinateMake(55.749475, 37.543084);
    
    [self.mapView addAnnotation:self.annotation];
    self.mapView.selectedAnnotation = self.annotation;
}

- (void)configureAnnotationView:(YMKPinAnnotationView *)view forAnnotation:(id<YMKAnnotation>)annotation {
    if (annotation == self.annotation) {
        view.calloutContentView = [CalloutView loadView];
    }
}

#pragma mark - Properties

@synthesize annotation;

#pragma mark - Memory Management

- (void)dealloc {
    self.annotation = nil;
    
    [super dealloc];
}

@end