//
//  TripPageViewController.h
//  Wanderlust
//
//  Created by Sidwyn Koh on 4/23/14.
//  Copyright (c) 2014 Wanderlust. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TripPageViewController : UIViewController <UIPageViewControllerDataSource> {
    int mainIndex;
}

@property (strong, nonatomic) UIPageViewController *pageController;

@end
