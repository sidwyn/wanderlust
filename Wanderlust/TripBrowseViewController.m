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
#define ADJUSTOR2 260
#define ADJUSTOR3 30

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
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *bookNowBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Book Now" style:UIBarButtonItemStylePlain target:self action:@selector(pushBookTripController)];
    self.navigationItem.rightBarButtonItem = bookNowBarButton;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
    
    CGRect currentFrame = self.view.bounds;
    mainScrollView = [[SpecialScrollView alloc] initWithFrame:self.view.bounds];
    mainScrollView.contentSize = CGSizeMake(320, 1630);
    mainScrollView.delegate = self;
    mainScrollView.tag = 111;
    
    mainScrollView.canCancelContentTouches = NO;
    mainScrollView.delaysContentTouches = NO;
    
    CGRect motionFrame = currentFrame;
    motionFrame.size.height -= 64;
    
    NSString *priceLabelText;
    NSString *placeImageText;
    NSString *reflectionImageText;
    NSString *venueLabelText;
    NSString *tripDescriptionLabelText;
    
    switch (self.index) {
        case 0:
            mainPlaceText = @"Yosemite";
            priceLabelText = @"$248";
            placeImageText = @"yosemite.jpg";
            reflectionImageText = @"yosemite-cut.jpg";
            venueLabelText = @"Yosemite Village, CA";
            tripDescriptionLabelText = @"Yosemite Valley is the crown jewel of the Sierra Nevada mountains. Located inside Yosemite National Park, 150 miles east of San Francisco, it is surely a great place to kick back from the busy city life.";
            latitude = 37.865101;
            longitude = -119.538329;
            break;
        case 1:
            mainPlaceText = @"Carmel";
            priceLabelText = @"$416";
            placeImageText = @"carmel.jpg";
            reflectionImageText = @"carmel-cut.jpg";
            venueLabelText = @"Carmel-by-the-sea, CA";
            tripDescriptionLabelText = @"Rated a top-10 destination in the U.S. year after year, Carmel-by-the-Sea is an amazing, European-style village nestled above a picturesque white-sand beach where everything is within walking distance from your charming hotel or inn.";
            latitude = 36.479900;
            longitude = -121.732796;
            break;
        case 2:
            mainPlaceText = @"Napa Valley";
            priceLabelText = @"$172";
            placeImageText = @"napavalley.jpg";
            reflectionImageText = @"napavalley-cut.jpg";
            venueLabelText = @"Napa County, CA";
            tripDescriptionLabelText = @"Whether you are wine tasting, dining at renowned restaurants like the French Laundry, pampering yourself with a mud bath in Calistoga, or just enjoying your stay at quaint bed & breakfasts, hotels or resorts ... Napa Valley is your spot of heaven on earth.";
            latitude = 38.5000;
            longitude = -122.3200;
            break;
    }
    
    
    
    motionView = [[CRMotionView alloc] initWithFrame:motionFrame];
    [motionView setImage:[UIImage imageNamed:placeImageText]];
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
    s1welcomeLabel.text = mainPlaceText;
    [mainScrollView addSubview:s1welcomeLabel];
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 360, 300, 40)];
    priceLabel.textAlignment = NSTextAlignmentRight;
    priceLabel.font = [UIFont fontWithName:@"Roboto-Regular" size:28];
    priceLabel.textColor = [UIColor whiteColor];
    priceLabel.text = priceLabelText;
    [mainScrollView addSubview:priceLabel];
    
    UIImageView *placeImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 405, 13, 13)];
    placeImage.image = [UIImage imageNamed:@"place"];
    [mainScrollView addSubview:placeImage];
    
    UILabel *venueLabel = [[UILabel alloc] initWithFrame:CGRectMake(26, 390, 300, 40)];
    venueLabel.textAlignment = NSTextAlignmentLeft;
    venueLabel.font = [UIFont fontWithName:@"Roboto-Regular" size:16];
    venueLabel.textColor = [UIColor whiteColor];
    venueLabel.text = venueLabelText;
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
    tripDescriptionLabel.text = tripDescriptionLabelText;
    tripDescriptionLabel.numberOfLines = 0;
    tripDescriptionLabel.textAlignment = NSTextAlignmentJustified;
    tripDescriptionLabel.backgroundColor = [UIColor clearColor];
    tripDescriptionLabel.textColor = [UIColor whiteColor];
    tripDescriptionLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
    [mainScrollView addSubview:tripDescriptionLabel];
    
    UIView *lineView01 = [[UIView alloc] initWithFrame:CGRectMake(20, currentFrame.size.height+130+ADJUSTOR, 280, 0.3)];
    lineView01.backgroundColor = [UIColor whiteColor];
    [mainScrollView addSubview:lineView01];
    
    UILabel *photoLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, currentFrame.size.height+140+ADJUSTOR, 280, 40)];
    photoLabel.textAlignment = NSTextAlignmentCenter;
    photoLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
    photoLabel.textColor = [UIColor whiteColor];
    photoLabel.text = @"Photos";
    [mainScrollView addSubview:photoLabel];
    
    UIScrollView *miniPhotoView = [[UIScrollView alloc] initWithFrame:CGRectMake(20, currentFrame.size.height+ADJUSTOR+180, 280, 180)];
    miniPhotoView.contentSize = CGSizeMake(280*5, 80);
    UIImageView *firstImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 280, 180)];
    UIImageView *secondImage = [[UIImageView alloc] initWithFrame:CGRectMake(280*1, 0, 280, 180)];
    UIImageView *thirdImage = [[UIImageView alloc] initWithFrame:CGRectMake(280*2, 0, 280, 180)];
    UIImageView *fourthImage = [[UIImageView alloc] initWithFrame:CGRectMake(280*3, 0, 280, 180)];
    UIImageView *fifthImage = [[UIImageView alloc] initWithFrame:CGRectMake(280*4, 0, 280, 180)];
    switch (self.index) {
        case 0:
            firstImage.image = [UIImage imageNamed:@"yosemite.jpg"];
            secondImage.image = [UIImage imageNamed:@"yosemite2.jpg"];
            thirdImage.image = [UIImage imageNamed:@"yosemite3.jpg"];
            fourthImage.image = [UIImage imageNamed:@"yosemite4.jpg"];
            fifthImage.image = [UIImage imageNamed:@"yosemite5.jpg"];
            break;
        case 1:
            firstImage.image = [UIImage imageNamed:@"carmel.jpg"];
            secondImage.image = [UIImage imageNamed:@"carmel2.jpg"];
            thirdImage.image = [UIImage imageNamed:@"carmel3.jpg"];
            fourthImage.image = [UIImage imageNamed:@"carmel4.jpg"];
            fifthImage.image = [UIImage imageNamed:@"carmel5.jpg"];
            break;
        case 2:
            firstImage.image = [UIImage imageNamed:@"napavalley.jpg"];
            secondImage.image = [UIImage imageNamed:@"napa2.jpg"];
            thirdImage.image = [UIImage imageNamed:@"napa3.jpg"];
            fourthImage.image = [UIImage imageNamed:@"napa4.jpg"];
            fifthImage.image = [UIImage imageNamed:@"napa5.jpg"];
            break;
            
        
    }
    miniPhotoView.pagingEnabled = YES;
    [miniPhotoView addSubview:firstImage];
    [miniPhotoView addSubview:secondImage];
    [miniPhotoView addSubview:thirdImage];
    [miniPhotoView addSubview:fourthImage];
    [miniPhotoView addSubview:fifthImage];
    [mainScrollView addSubview:miniPhotoView];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openPhotosController)];
    singleTap.delaysTouchesBegan = NO;
    [miniPhotoView addGestureRecognizer:singleTap];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20, currentFrame.size.height+130+ADJUSTOR+ADJUSTOR2, 280, 0.3)];
    lineView.backgroundColor = [UIColor whiteColor];
    [mainScrollView addSubview:lineView];
    
    UILabel *detailsHeaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, currentFrame.size.height-15+160+ADJUSTOR+ADJUSTOR2, 280, 40)];
    detailsHeaderLabel.textAlignment = NSTextAlignmentCenter;
    detailsHeaderLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
    detailsHeaderLabel.textColor = [UIColor whiteColor];
    detailsHeaderLabel.text = @"Details";
    [mainScrollView addSubview:detailsHeaderLabel];
    
    UITableView *tripTable = [[UITableView alloc] initWithFrame:CGRectMake(5, currentFrame.size.height+175+ADJUSTOR+ADJUSTOR2, 310, 230)];
    tripTable.delegate = self;
    tripTable.dataSource = self;
    tripTable.backgroundColor = [UIColor clearColor];
    tripTable.scrollEnabled = NO;
    tripTable.allowsSelection = NO;
    tripTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [mainScrollView addSubview:tripTable];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(20, currentFrame.size.height+350+ADJUSTOR+ADJUSTOR2+ADJUSTOR3, 280, 0.3)];
    lineView2.backgroundColor = [UIColor whiteColor];
    [mainScrollView addSubview:lineView2];
    
    UILabel *mapHeaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, currentFrame.size.height+370+ADJUSTOR+ADJUSTOR2+ADJUSTOR3, 280, 40)];
    mapHeaderLabel.textAlignment = NSTextAlignmentCenter;
    mapHeaderLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
    mapHeaderLabel.textColor = [UIColor whiteColor];
    mapHeaderLabel.text = @"Map";
    [mainScrollView addSubview:mapHeaderLabel];
    
    mapView = [[MKMapView alloc] initWithFrame:CGRectMake(20, currentFrame.size.height+420+ADJUSTOR+ADJUSTOR2+ADJUSTOR3, 280, 160)];
    [mainScrollView addSubview:mapView];
    
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushMapViewController)];
    tgr.delaysTouchesBegan = NO;
    [mapView addGestureRecognizer:tgr];
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = latitude;
    zoomLocation.longitude= longitude;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 40*METERS_PER_MILE, 40*METERS_PER_MILE);
    [mapView setRegion:viewRegion animated:YES];
    
    MKPointAnnotation *myAnnotation = [[MKPointAnnotation alloc]init];
    myAnnotation.coordinate = zoomLocation;
    myAnnotation.title = mainPlaceText;
    myAnnotation.subtitle = venueLabelText;
    [mapView addAnnotation:myAnnotation];
    [mapView selectAnnotation:myAnnotation animated:YES];
    
    notifyButton = [KHFlatButton buttonWithFrame:CGRectMake(20, currentFrame.size.height+605+ADJUSTOR+ADJUSTOR2+ADJUSTOR3, 135, 50) withTitle:@"NOTIFY ME" backgroundColor:UIColorFromRGB(0x475755)];
    [notifyButton addTarget:self action:@selector(subscribeNotifications) forControlEvents:UIControlEventTouchUpInside];
    
    KHFlatButton *bookTripButton = [KHFlatButton buttonWithFrame:CGRectMake(165, currentFrame.size.height+605+ADJUSTOR+ADJUSTOR2+ADJUSTOR3, 135, 50) withTitle:@"BOOK TRIP" backgroundColor:UIColorFromRGB(0x3cb7a3)];
    [bookTripButton addTarget:self action:@selector(pushBookTripController) forControlEvents:UIControlEventTouchUpInside];
    [mainScrollView addSubview:notifyButton];
    [mainScrollView addSubview:bookTripButton];
    
    
    UIImageView *backgroundContentView = [[UIImageView alloc] initWithFrame:CGRectMake(0, currentFrame.size.height-64, 320, 1200)];
    backgroundContentView.image = [UIImage imageNamed:reflectionImageText];
    backgroundContentView.alpha = 0.5;
    [mainScrollView addSubview:backgroundContentView];
    [mainScrollView sendSubviewToBack:backgroundContentView];
    UIView *blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 2000)];
    blackView.backgroundColor = [UIColor blackColor];
    [mainScrollView addSubview:blackView];
    [mainScrollView sendSubviewToBack:blackView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [motionView setMotionEnabled:NO];
//    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)openPhotosController {
    
    EBPhotoPagesController *photoPagesController = [[EBPhotoPagesController alloc]
                                                    initWithDataSource:self delegate:self];
    
    [self presentViewController:photoPagesController animated:YES completion:nil];
}

- (void)pushBookTripController{
    BookTripViewController *btvc = [[BookTripViewController alloc] init];
    btvc.title = @"Book Your Trip";
    btvc.destination = mainPlaceText;
    [self.navigationController pushViewController:btvc animated:YES];
}

- (void)pushMapViewController {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TripMapViewController *tmvc = (TripMapViewController *)[sb instantiateViewControllerWithIdentifier:@"TripMapViewController"];
    tmvc.title = @"Map";
    tmvc.latitude = latitude;
    tmvc.longitude = longitude;
    tmvc.index = self.index;
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
        [mainScrollView scrollRectToVisible:CGRectMake(0, currentFrame.size.height-118, currentFrame.size.width, currentFrame.size.height) animated:YES];
    }
}

- (void)subscribeNotifications {
    if (!isSubscribed) {
        UIAlertView *subscribeAlert = [[UIAlertView alloc] initWithTitle:@"You're Subscribed!" message:@"We'll keep you up to date with price changes for this trip." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [subscribeAlert show];
        [notifyButton setTitle:@"REMOVE TRIP" forState:UIControlStateNormal];
    }
    else {
        [notifyButton setTitle:@"SAVE TRIP" forState:UIControlStateNormal];
    }
    isSubscribed = !isSubscribed;
}


- (BOOL)photoPagesController:(EBPhotoPagesController *)photoPagesController
    shouldExpectPhotoAtIndex:(NSInteger)index {
    NSLog(@"Index is %i", index);
    if (index >=0 && index < 5)
        return YES;
    else return NO;
}


- (UIImage *)photoPagesController:(EBPhotoPagesController *)controller
                     imageAtIndex:(NSInteger)index {
    NSLog(@"Index is %i", index);
    NSLog(@"self.Index is %i", self.index);
    switch (self.index) {
        case 0: // yosemite
            switch (index) {
                case 0:
                    return [UIImage imageNamed:@"yosemite.jpg"];
                    break;
                case 1:
                    return [UIImage imageNamed:@"yosemite2.jpg"];
                case 2:
                    return [UIImage imageNamed:@"yosemite3.jpg"];
                case 3:
                    return [UIImage imageNamed:@"yosemite4.jpg"];
                case 4:
                    return [UIImage imageNamed:@"yosemite5.jpg"];
            }
            break;
        case 1: // carmel
            switch (index) {
                case 0:
                    return [UIImage imageNamed:@"carmel.jpg"];
                case 1:
                    return [UIImage imageNamed:@"carmel2.jpg"];
                case 2:
                    return [UIImage imageNamed:@"carmel3.jpg"];
                case 3:
                    return [UIImage imageNamed:@"carmel4.jpg"];
                case 4:
                    return [UIImage imageNamed:@"carmel5.jpg"];
            }
            break;
        case 2: // napa
            switch (index) {
                case 0:
                    return [UIImage imageNamed:@"napavalley.jpg"];
                case 1:
                    return [UIImage imageNamed:@"napa2.jpg"];
                case 2:
                    return [UIImage imageNamed:@"napa3.jpg"];
                case 3:
                    return [UIImage imageNamed:@"napa4.jpg"];
                case 4:
                    return [UIImage imageNamed:@"napa5.jpg"];
            }
            break;
    }
    return [UIImage imageNamed:@"yosemite.jpg"];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
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
    
    NSString *durationText;
    NSString *activitiesText;
    NSString *distanceText;
    NSString *travelTimeText;
    NSString *lodgingText;
    NSString *datesText = @"May 2nd - 4th";
    
    switch (self.index) {
        case 0:
            durationText = @"3 days";
            activitiesText = @"Hiking, horseriding, tours";
            distanceText = @"198 miles";
            travelTimeText = @"4 hours by car";
            lodgingText = @"Yosemite Lodge at the Falls";
            break;
        case 1:
            durationText = @"2 days";
            activitiesText = @"Shopping, beaches, golf";
            distanceText = @"198 miles";
            travelTimeText = @"2 hours by car";
            lodgingText = @"Carmel California Inn";
            break;
        case 2:
            durationText = @"3 days";
            activitiesText = @"Vineyards, mud baths";
            distanceText = @"230 miles";
            travelTimeText = @"3 hours by car";
            lodgingText = @"Napa River Inn";
            break;
    }
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Duration";
            cell.detailTextLabel.text = durationText;
            break;
        case 1:
            cell.textLabel.text = @"Activities";
            cell.detailTextLabel.text = activitiesText;
            break;
        case 2:
            cell.textLabel.text = @"Distance";
            cell.detailTextLabel.text = distanceText;
            break;
        case 3:
            cell.textLabel.text = @"Driving Time";
            cell.detailTextLabel.text = travelTimeText;
            break;
        case 4:
            cell.textLabel.text = @"Lodging";
            cell.detailTextLabel.text = lodgingText;
            break;
        case 5:
            cell.textLabel.text = @"Dates";
            cell.detailTextLabel.text = datesText;
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
