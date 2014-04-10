//
//  TripBrowseViewController.m
//  Wanderlust
//
//  Created by Sidwyn Koh on 4/3/14.
//  Copyright (c) 2014 Wanderlust. All rights reserved.
//

#import "TripBrowseViewController.h"
#import "CRMotionView.h"
#include "TargetConditionals.h"
#import <KHFlatButton/KHFlatButton.h>
#import "TripMapViewController.h"
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
    
    CGRect currentFrame = self.view.bounds;
    
    mainScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    mainScrollView.contentSize = CGSizeMake(320, 1200);
    
    CRMotionView *motionView = [[CRMotionView alloc] initWithFrame:self.view.bounds];
    [motionView setImage:[UIImage imageNamed:@"yosemite.jpg"]];
    [self.view addSubview:motionView];
#if TARGET_IPHONE_SIMULATOR
    [motionView setMotionEnabled:NO];
#endif
    
    [mainScrollView addSubview:motionView];
    
    
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
    
    UILabel *tripDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, currentFrame.size.height+0, 280, 200)];
    tripDescriptionLabel.text = @"Yosemite Valley is the crown jewel of the Sierra Nevada mountains. Located inside Yosemite National Park, 150 miles east of San Francisco, it is surely a great place to kick back from the busy city life.";
    tripDescriptionLabel.numberOfLines = 0;
    tripDescriptionLabel.backgroundColor = [UIColor clearColor];
    tripDescriptionLabel.textColor = [UIColor whiteColor];
    [mainScrollView addSubview:tripDescriptionLabel];
    
    UITableView *tripTable = [[UITableView alloc] initWithFrame:CGRectMake(10, currentFrame.size.height+170, 300, 200)];
    tripTable.delegate = self;
    tripTable.dataSource = self;
    tripTable.backgroundColor = [UIColor clearColor];
    tripTable.scrollEnabled = NO;
    [mainScrollView addSubview:tripTable];
    
    mapView = [[MKMapView alloc] initWithFrame:CGRectMake(20, currentFrame.size.height+380, 280, 160)];
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
    
    
    KHFlatButton *notifyButton = [KHFlatButton buttonWithFrame:CGRectMake(20, currentFrame.size.height+565, 140, 50) withTitle:@"NOTIFY ME" backgroundColor:UIColorFromRGB(0x475755)];
    KHFlatButton *bookTripButton = [KHFlatButton buttonWithFrame:CGRectMake(170, currentFrame.size.height+565, 140, 50) withTitle:@"BOOK TRIP" backgroundColor:UIColorFromRGB(0x3cb7a3)];
    [mainScrollView addSubview:notifyButton];
    [mainScrollView addSubview:bookTripButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)pushMapViewController {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TripMapViewController *tmvc = (TripMapViewController *)[sb instantiateViewControllerWithIdentifier:@"TripMapViewController"];
    tmvc.title = @"Yosemite";
    [self.navigationController pushViewController:tmvc animated:YES];
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
