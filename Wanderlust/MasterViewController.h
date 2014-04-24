//
//  MasterViewController.h
//  Wanderlust
//
//  Created by Sidwyn Koh on 4/3/14.
//  Copyright (c) 2014 Wanderlust. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TutorialViewController.h"
#import "MyTripsTableViewController.h"


@interface MasterViewController : UITableViewController <TutorialViewControllerDelegate, MyTripsTableViewControllerDelegate, RNFrostedSidebarDelegate> {
    RNFrostedSidebar *callout;
}
- (void)pushMyTripsController;
@end
