//
//  TripMapViewController.h
//  Wanderlust
//
//  Created by Sidwyn Koh on 4/10/14.
//  Copyright (c) 2014 Wanderlust. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface TripMapViewController : UIViewController <MKMapViewDelegate> {
    IBOutlet MKMapView *mapView;
    
    MKPointAnnotation *myAnnotation;
    CLLocationCoordinate2D zoomLocation;
    
    
}


@property (nonatomic, assign) float latitude;
@property (nonatomic, assign) float longitude;
@property (nonatomic, assign) int index;

@end
