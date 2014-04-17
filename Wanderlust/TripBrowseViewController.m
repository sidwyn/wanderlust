//
//  TripBrowseViewController.m
//  Wanderlust
//
//  Created by Sidwyn Koh on 4/3/14.
//  Copyright (c) 2014 Wanderlust. All rights reserved.
//

#import "TripBrowseViewController.h"
#include "TargetConditionals.h"
#import "TripMapViewController.h"
#import "BookTripViewController.h"

#define SCROLL_UP_BUTTON_TAG 111
#define SCROLL_DOWN_BUTTON_TAG 112
#define ADJUSTOR 40

@interface TripBrowseViewController ()

@end

@implementation TripBrowseViewController

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
    
    UIBarButtonItem *bookNowBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Book Now" style:UIBarButtonItemStylePlain target:self action:@selector(pushBookTripController)];
    self.navigationItem.rightBarButtonItem = bookNowBarButton;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
    
    CGRect currentFrame = self.view.bounds;
    
    mainScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    mainScrollView.contentSize = CGSizeMake(320, 1260);
    mainScrollView.delegate = self;
    mainScrollView.tag = 111;
    
//    mainScrollView.canCancelContentTouches = NO;
    mainScrollView.delaysContentTouches = NO;
    
    CGRect motionFrame = currentFrame;
    motionFrame.size.height -= 64;
    
    motionView = [[CRMotionView alloc] initWithFrame:motionFrame];
    [motionView setImage:[UIImage imageNamed:@"yosemite.jpg"]];
    [self.view addSubview:motionView];
#if TARGET_IPHONE_SIMULATOR
    [motionView setMotionEnabled:NO];
#endif
    
    [mainScrollView addSubview:motionView];
    
    self.title = @"Yosemite";
    
    UILabel *s1welcomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 360, 300, 40)];
    s1welcomeLabel.textAlignment = NSTextAlignmentLeft;
    s1welcomeLabel.font = [UIFont fontWithName:@"Roboto-Bold" size:32];
    s1welcomeLabel.textColor = [UIColor whiteColor];
    s1welcomeLabel.text = @"Yosemite";
    [mainScrollView addSubview:s1welcomeLabel];
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 360, 300, 40)];
    priceLabel.textAlignment = NSTextAlignmentRight;
    priceLabel.font = [UIFont fontWithName:@"Roboto-Regular" size:28];
    priceLabel.textColor = [UIColor whiteColor];
    priceLabel.text = @"$248";
    [mainScrollView addSubview:priceLabel];
    
    UIImageView *placeImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 405, 13, 13)];
    placeImage.image = [UIImage imageNamed:@"place"];
    [mainScrollView addSubview:placeImage];
    
    UILabel *venueLabel = [[UILabel alloc] initWithFrame:CGRectMake(26, 390, 300, 40)];
    venueLabel.textAlignment = NSTextAlignmentLeft;
    venueLabel.font = [UIFont fontWithName:@"Roboto-Regular" size:16];
    venueLabel.textColor = [UIColor whiteColor];
    venueLabel.text = @"Yosemite Village, CA";
    [mainScrollView addSubview:venueLabel];
    
    [self.view addSubview:mainScrollView];
    
    UIButton *scrollDownButton = [[UIButton alloc] initWithFrame:CGRectMake(currentFrame.size.width/2-20, currentFrame.size.height-40-94, 40, 40)];
    [scrollDownButton setImage:[UIImage imageNamed:@"arrowdown.png"] forState:UIControlStateNormal];
    scrollDownButton.tag = SCROLL_DOWN_BUTTON_TAG;
    [scrollDownButton addTarget:self action:@selector(scrollAround:) forControlEvents:UIControlEventTouchUpInside];
    [mainScrollView addSubview:scrollDownButton];
    
    UIButton *scrollUpButton = [[UIButton alloc] initWithFrame:CGRectMake(currentFrame.size.width/2-20, currentFrame.size.height-50, 40, 40)];
    [scrollUpButton setImage:[UIImage imageNamed:@"arrowup.png"] forState:UIControlStateNormal];
    scrollUpButton.tag = SCROLL_UP_BUTTON_TAG;
    [scrollUpButton addTarget:self action:@selector(scrollAround:) forControlEvents:UIControlEventTouchUpInside];
    [mainScrollView addSubview:scrollUpButton];
    
    UIView *lineView0 = [[UIView alloc] initWithFrame:CGRectMake(20, currentFrame.size.height+10, 280, 0.3)];
    lineView0.backgroundColor = [UIColor whiteColor];
    [mainScrollView addSubview:lineView0];
    
    UILabel *descriptionHeaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, currentFrame.size.height-20+ADJUSTOR, 280, 40)];
    descriptionHeaderLabel.textAlignment = NSTextAlignmentCenter;
    descriptionHeaderLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
    descriptionHeaderLabel.textColor = [UIColor whiteColor];
    descriptionHeaderLabel.text = @"About";
    [mainScrollView addSubview:descriptionHeaderLabel];
    
    UILabel *tripDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, currentFrame.size.height-40+ADJUSTOR, 280, 200)];
    tripDescriptionLabel.text = @"Yosemite Valley is the crown jewel of the Sierra Nevada mountains. Located inside Yosemite National Park, 150 miles east of San Francisco, it is surely a great place to kick back from the busy city life.";
    tripDescriptionLabel.numberOfLines = 0;
    tripDescriptionLabel.textAlignment = NSTextAlignmentJustified;
    tripDescriptionLabel.backgroundColor = [UIColor clearColor];
    tripDescriptionLabel.textColor = [UIColor whiteColor];
    tripDescriptionLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
    [mainScrollView addSubview:tripDescriptionLabel];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20, currentFrame.size.height+130+ADJUSTOR, 280, 0.3)];
    lineView.backgroundColor = [UIColor whiteColor];
    [mainScrollView addSubview:lineView];
    
    UILabel *detailsHeaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, currentFrame.size.height-15+160+ADJUSTOR, 280, 40)];
    detailsHeaderLabel.textAlignment = NSTextAlignmentCenter;
    detailsHeaderLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
    detailsHeaderLabel.textColor = [UIColor whiteColor];
    detailsHeaderLabel.text = @"Details";
    [mainScrollView addSubview:detailsHeaderLabel];
    
    UITableView *tripTable = [[UITableView alloc] initWithFrame:CGRectMake(5, currentFrame.size.height+175+ADJUSTOR, 310, 200)];
    tripTable.delegate = self;
    tripTable.dataSource = self;
    tripTable.backgroundColor = [UIColor clearColor];
    tripTable.scrollEnabled = NO;
    tripTable.allowsSelection = NO;
    tripTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [mainScrollView addSubview:tripTable];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(20, currentFrame.size.height+320+ADJUSTOR, 280, 0.3)];
    lineView2.backgroundColor = [UIColor whiteColor];
    [mainScrollView addSubview:lineView2];
    
    UILabel *mapHeaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, currentFrame.size.height+340+ADJUSTOR, 280, 40)];
    mapHeaderLabel.textAlignment = NSTextAlignmentCenter;
    mapHeaderLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
    mapHeaderLabel.textColor = [UIColor whiteColor];
    mapHeaderLabel.text = @"Map";
    [mainScrollView addSubview:mapHeaderLabel];
    
    mapView = [[MKMapView alloc] initWithFrame:CGRectMake(20, currentFrame.size.height+390+ADJUSTOR, 280, 160)];
    [mainScrollView addSubview:mapView];
    
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushMapViewController)];
    [mapView addGestureRecognizer:tgr];
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 37.865101;
    zoomLocation.longitude= -119.538329;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 40*METERS_PER_MILE, 40*METERS_PER_MILE);
    [mapView setRegion:viewRegion animated:YES];
    
    MKPointAnnotation *myAnnotation = [[MKPointAnnotation alloc]init];
    myAnnotation.coordinate = zoomLocation;
    myAnnotation.title = @"Yosemite";
    myAnnotation.subtitle = @"Yosemite Village, CA";
    [mapView addAnnotation:myAnnotation];
    [mapView selectAnnotation:myAnnotation animated:YES];
    
    notifyButton = [KHFlatButton buttonWithFrame:CGRectMake(20, currentFrame.size.height+575+ADJUSTOR, 135, 50) withTitle:@"NOTIFY ME" backgroundColor:UIColorFromRGB(0x475755)];
    [notifyButton addTarget:self action:@selector(subscribeNotifications) forControlEvents:UIControlEventTouchUpInside];
    
    KHFlatButton *bookTripButton = [KHFlatButton buttonWithFrame:CGRectMake(165, currentFrame.size.height+575+ADJUSTOR, 135, 50) withTitle:@"BOOK TRIP" backgroundColor:UIColorFromRGB(0x3cb7a3)];
    [bookTripButton addTarget:self action:@selector(pushBookTripController) forControlEvents:UIControlEventTouchUpInside];
    [mainScrollView addSubview:notifyButton];
    [mainScrollView addSubview:bookTripButton];
    
    UIImageView *backgroundContentView = [[UIImageView alloc] initWithFrame:CGRectMake(0, currentFrame.size.height-64, 320, 900)];
    backgroundContentView.image = [UIImage imageNamed:@"yosemite2.jpg"];
    [mainScrollView addSubview:backgroundContentView];
    [mainScrollView sendSubviewToBack:backgroundContentView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void) viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
//}
//
- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [motionView setMotionEnabled:NO];
//    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)pushBookTripController{
    BookTripViewController *btvc = [[BookTripViewController alloc] init];
    btvc.title = @"Book Your Trip";
    [self.navigationController pushViewController:btvc animated:YES];
}

- (void)pushMapViewController {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TripMapViewController *tmvc = (TripMapViewController *)[sb instantiateViewControllerWithIdentifier:@"TripMapViewController"];
    tmvc.title = @"Yosemite";
    [self.navigationController pushViewController:tmvc animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.tag == 111) {
        if (scrollView.contentOffset.y <= 0) {
            motionView.motionEnabled = YES;
        }
        else {
            motionView.motionEnabled = NO;
        }
    }
}

- (void)scrollAround:(UIButton *)sender{
    CGRect currentFrame = self.view.bounds;
    
    if (sender.tag == SCROLL_UP_BUTTON_TAG) {
        [mainScrollView scrollRectToVisible:CGRectMake(0, 0, currentFrame.size.width, currentFrame.size.height) animated:YES];
    }
    else {
        [mainScrollView scrollRectToVisible:CGRectMake(0, currentFrame.size.height-120, currentFrame.size.width, currentFrame.size.height) animated:YES];
    }
}

- (void)subscribeNotifications {
    if (!isSubscribed) {
        UIAlertView *subscribeAlert = [[UIAlertView alloc] initWithTitle:@"You're Subscribed!" message:@"We'll keep you up to date with price changes for this trip." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [subscribeAlert show];
        [notifyButton setTitle:@"CANCEL NOTIFICATIONS" forState:UIControlStateNormal];
    }
    else {
        [notifyButton setTitle:@"NOTIFY ME" forState:UIControlStateNormal];
    }
    isSubscribed = !isSubscribed;
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
        NSLog(@"Hihihi");
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
        cell.detailTextLabel.textColor = [UIColor whiteColor];
        cell.detailTextLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
    }
    cell.backgroundColor = [UIColor clearColor];
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Duration";
            cell.detailTextLabel.text = @"3 days";
            break;
        case 1:
            cell.textLabel.text = @"Activities";
            cell.detailTextLabel.text = @"Hiking, horseriding, tours";
            break;
        case 2:
            cell.textLabel.text = @"Distance";
            cell.detailTextLabel.text = @"198 miles / 240 km";
            break;
        case 3:
            cell.textLabel.text = @"Travel Time";
            cell.detailTextLabel.text = @"4 hours by car";
            break;
            
        default:
            break;
    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TripBrowseViewController *tbvc = [[TripBrowseViewController alloc] init];
    [self.navigationController pushViewController:tbvc animated:YES];
}

@end
