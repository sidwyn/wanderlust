//
//  TutorialViewController.h
//  Wanderlust
//
//  Created by Sidwyn Koh on 4/3/14.
//  Copyright (c) 2014 Wanderlust. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TutorialViewController : UIViewController <UIScrollViewDelegate> {
    IBOutlet UIScrollView *tutorialScrollView;
    IBOutlet UIPageControl *pageControl;
    IBOutlet UIImageView *backgroundImageView;
}

@end
