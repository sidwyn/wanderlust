//
//  TripBrowseViewController.h
//  Wanderlust
//
//  Created by Sidwyn Koh on 4/3/14.
//  Copyright (c) 2014 Wanderlust. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface TripBrowseViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    UIScrollView *mainScrollView;
    MKMapView *mapView;
}

@end
