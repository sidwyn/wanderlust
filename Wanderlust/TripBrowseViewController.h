//
//  TripBrowseViewController.h
//  Wanderlust
//
//  Created by Sidwyn Koh on 4/3/14.
//  Copyright (c) 2014 Wanderlust. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CRMotionView.h"
#import <KHFlatButton/KHFlatButton.h>

@interface TripBrowseViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate> {
    UIScrollView *mainScrollView;
    MKMapView *mapView;
    CRMotionView *motionView;
    KHFlatButton *notifyButton;
    BOOL isSubscribed;
}

@end
