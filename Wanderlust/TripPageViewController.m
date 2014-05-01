//
//  TripPageViewController.m
//  Wanderlust
//
//  Created by Sidwyn Koh on 4/23/14.
//  Copyright (c) 2014 Wanderlust. All rights reserved.
//

#import "TripPageViewController.h"
#import "TripBrowseViewController.h"
#import "BookTripViewController.h"

@interface TripPageViewController ()

@end

@implementation TripPageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *bookNowBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Book Trip" style:UIBarButtonItemStylePlain target:self action:@selector(pushBookTripController)];
    self.navigationItem.rightBarButtonItem = bookNowBarButton;
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageController.delegate = self;
    self.pageController.dataSource = self;
    [[self.pageController view] setFrame:[[self view] bounds]];
    
    TripBrowseViewController *initialViewController = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];

    if (self.pageNumber > YOSEMITEPAGE) {
        [self.pageController setViewControllers:@[[self viewControllerAtIndex:self.pageNumber-111]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    }
    
    [self addChildViewController:self.pageController];
    
    CGRect tempFrame = self.pageController.view.frame;
    tempFrame.origin.y += 0;
    tempFrame.size.height += 64;
    self.pageController.view.frame = tempFrame;
//    self.pageController.view.frame.ori = CGRectMake(0, 64, currentFrame.size.height-64, currentFrame.size.width);
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
    
}

- (void)pushBookTripController{
    BookTripViewController *btvc = [[BookTripViewController alloc] init];
    btvc.title = @"Book Your Trip";
    switch (mainIndex) {
        case 0:
            btvc.destination = @"Yosemite";
            break;
        case 1:
            btvc.destination = @"Carmel";
            break;
        case 2:
            btvc.destination = @"Napa Valley";
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:btvc animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(TripBrowseViewController *)viewController index];
    
    if (index == 0) {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(TripBrowseViewController *)viewController index];
    
    index++;
        if (index == 3) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
    
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed) {
        
        int currentIndex = [((TripBrowseViewController *)[pageViewController.viewControllers objectAtIndex:0]) index];
        NSLog(@"Animation complete to %i", currentIndex);
        
        mainIndex = currentIndex;

        switch (currentIndex) {
            case 0:
                self.title = @"Yosemite";
                break;
            case 1:
                self.title = @"Carmel";
                break;
            case 2:
                self.title = @"Napa Valley";
                break;
            default:
                break;
        }
    }
    
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator.
    return 3;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
    return 0;
}

- (TripBrowseViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    TripBrowseViewController *childViewController = [[TripBrowseViewController alloc] init];
    childViewController.index = index;
    if (index == 0)
        self.title = @"Yosemite";
    else if (index == 1) {
        self.title = @"Carmel";
    }
    else if (index == 2) {
        self.title = @"Napa Valley";
    }
    return childViewController;
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
