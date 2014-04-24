//
//  TripMapViewController.m
//  Wanderlust
//
//  Created by Sidwyn Koh on 4/10/14.
//  Copyright (c) 2014 Wanderlust. All rights reserved.
//

#import "TripMapViewController.h"

@interface TripMapViewController ()

@end

@implementation TripMapViewController

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
    
    zoomLocation.latitude = self.latitude;
    zoomLocation.longitude= self.longitude;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 40*METERS_PER_MILE, 40*METERS_PER_MILE);
    [mapView setRegion:viewRegion animated:YES];
    
    
    
    myAnnotation = [[MKPointAnnotation alloc]init];
    myAnnotation.coordinate = zoomLocation;
    switch (self.index) {
        case 0:
            myAnnotation.title = @"Yosemite";
            myAnnotation.subtitle = @"Yosemite Village, CA";
            break;
        case 1:
            myAnnotation.title = @"Carmel";
            myAnnotation.subtitle = @"Carmel-by-the-sea, CA";
            break;
        case 2:
            myAnnotation.title = @"Napa Valley";
            myAnnotation.subtitle = @"Napa County, CA";
            break;
        default:
            break;
    }
    [mapView addAnnotation:myAnnotation];
    [mapView selectAnnotation:myAnnotation animated:YES];
    
    UIBarButtonItem *directionsButton = [[UIBarButtonItem alloc] initWithTitle:@"Directions" style:UIBarButtonItemStylePlain target:self action:@selector(openActionSheet:)];
    self.navigationItem.rightBarButtonItem = directionsButton;
}

-(void)openActionSheet:(id)sender {
    //give the user a choice of Apple or Google Maps
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Open in Maps" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Apple Maps", @"Google Maps", nil];
    [sheet showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    //coordinates for the place we want to display
    CLLocationCoordinate2D rdOfficeLocation = CLLocationCoordinate2DMake(self.latitude, self.longitude);
    if (buttonIndex==0) {
        //Apple Maps, using the MKMapItem class
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:rdOfficeLocation addressDictionary:nil];
        MKMapItem *item = [[MKMapItem alloc] initWithPlacemark:placemark];
        
        switch (self.index) {
            case 0:
                item.name = @"Yosemite";
                break;
            case 1:
                item.name = @"Carmel";
                break;
            case 2:
                item.name = @"Napa Valley";
                break;
        }
        [item openInMapsWithLaunchOptions:nil];
    } else if (buttonIndex==1) {
        //Google Maps
        //construct a URL using the comgooglemaps schema
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"comgooglemaps://?center=%f,%f",rdOfficeLocation.latitude,rdOfficeLocation.longitude]];
        if (![[UIApplication sharedApplication] canOpenURL:url]) {
            NSLog(@"Google Maps app is not installed.");
            //left as an exercise for the reader: open the Google Maps mobile website instead!
        } else {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
