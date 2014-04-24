//
//  MyTripsTableViewController.h
//  Wanderlust
//
//  Created by Sidwyn Koh on 4/17/14.
//  Copyright (c) 2014 Wanderlust. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyTripsTableViewControllerDelegate;

@interface MyTripsTableViewController : UITableViewController <RNFrostedSidebarDelegate>
@property (nonatomic, assign) id <MyTripsTableViewControllerDelegate> delegate;

@end


@protocol MyTripsTableViewControllerDelegate
@required
- (void)closeMyTripsController;
@end