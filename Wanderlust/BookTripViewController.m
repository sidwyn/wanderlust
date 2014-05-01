//
//  BookTripViewController.m
//  Wanderlust
//
//  Created by Sidwyn Koh on 4/17/14.
//  Copyright (c) 2014 Wanderlust. All rights reserved.
//

#import "BookTripViewController.h"
#import "MBProgressHUD.h"
#import "MasterViewController.h"

#define SEPARATOR 64

@interface BookTripViewController ()

@end

@implementation BookTripViewController

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
    self.view.backgroundColor = UIColorFromRGB(0xbdc3c7);
    
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    CGRect currentFrame = self.view.bounds;
    
    UILabel *s1welcomeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 80-SEPARATOR, 300, 40)];
    s1welcomeLabel.textAlignment = NSTextAlignmentLeft;
    s1welcomeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
    s1welcomeLabel.textColor = UIColorFromRGB(0x2c3e50);
    s1welcomeLabel.text = @"Trip Confirmation";
    [self.view addSubview:s1welcomeLabel];
    
    UIImageView *calendarImage = [[UIImageView alloc] initWithFrame:CGRectMake(30, 130-SEPARATOR, 60, 60)];
    calendarImage.image = [UIImage imageNamed:@"calendar"];
    [self.view addSubview:calendarImage];
    
    UILabel *calendarLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 180-SEPARATOR, 80, 50)];
    calendarLabel.textAlignment = NSTextAlignmentCenter;
    calendarLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    calendarLabel.textColor = UIColorFromRGB(0x2c3e50);
    calendarLabel.numberOfLines = 0;
    calendarLabel.text = @"May 2 - 4";
    [self.view addSubview:calendarLabel];
    
    UIImageView *placemarkImage = [[UIImageView alloc] initWithFrame:CGRectMake(100+30, 130-SEPARATOR, 60, 60)];
    placemarkImage.image = [UIImage imageNamed:@"placemark"];
    [self.view addSubview:placemarkImage];
    
    UILabel *placemarkLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 180-SEPARATOR, 100, 50)];
    placemarkLabel.textAlignment = NSTextAlignmentCenter;
    placemarkLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    placemarkLabel.textColor = UIColorFromRGB(0x2c3e50);
    placemarkLabel.numberOfLines = 0;
    placemarkLabel.text = self.destination;
    [self.view addSubview:placemarkLabel];
    
    UIImageView *peopleImage = [[UIImageView alloc] initWithFrame:CGRectMake(200+30, 130-SEPARATOR, 60, 60)];
    peopleImage.image = [UIImage imageNamed:@"man"];
    [self.view addSubview:peopleImage];
    
    UILabel *peopleLabel = [[UILabel alloc] initWithFrame:CGRectMake(220, 180-SEPARATOR, 80, 50)];
    peopleLabel.textAlignment = NSTextAlignmentCenter;
    peopleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    peopleLabel.textColor = UIColorFromRGB(0x2c3e50);
    peopleLabel.numberOfLines = 0;
    peopleLabel.text = @"1 Person";
    [self.view addSubview:peopleLabel];
    
    paymentButton = [KHFlatButton buttonWithFrame:CGRectMake(0+20, 250-SEPARATOR, 280, 50) withTitle:@"ENTER PAYMENT INFO" backgroundColor:UIColorFromRGB(0x3cb7a3)];
    [paymentButton addTarget:self action:@selector(pushPaymentController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:paymentButton];
    
    finalBookTripButton = [KHFlatButton buttonWithFrame:CGRectMake(0+20, 320-SEPARATOR, 280, 50) withTitle:@"BOOK TRIP" backgroundColor:UIColorFromRGB(0x3cb7a3)];
    [finalBookTripButton addTarget:self action:@selector(bookTrip) forControlEvents:UIControlEventTouchUpInside];
    finalBookTripButton.hidden = YES;
    [self.view addSubview:finalBookTripButton];
    
    checkmarkImage = [[UIImageView alloc] initWithFrame:CGRectMake(60, 15, 20, 20)];
    checkmarkImage.image = [UIImage imageNamed:@"checkmark.png"];
    checkmarkImage.hidden = YES;
    [paymentButton addSubview:checkmarkImage];
}

- (void)pushPaymentController {
    PaymentViewController *pvc = [[PaymentViewController alloc] init];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:pvc];
    pvc.delegate = self;
    [self presentViewController:nc animated:YES completion:nil];
}

- (void)closePaymentController:(BOOL)withPayment {
    [self dismissViewControllerAnimated:YES completion:nil];
    if (withPayment) {
        [paymentButton setTitle:@"      PAYMENT ON FILE" forState:UIControlStateNormal];
        checkmarkImage.hidden = NO;
        finalBookTripButton.hidden = NO;
        paymentButton.alpha = 0.5;
    }
    
}

- (void)bookTrip {
    // replace right bar button 'refresh' with spinner
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // how we stop refresh from freezing the main UI thread
    dispatch_queue_t downloadQueue = dispatch_queue_create("downloader", NULL);
    dispatch_async(downloadQueue, ^{
        
        // do our long running process here
        [NSThread sleepForTimeInterval:2];
        
        // do any UI stuff on the main UI thread
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            NSArray *viewControllers = self.navigationController.viewControllers;
            MasterViewController *rootViewController = (MasterViewController *) [viewControllers objectAtIndex:0];
            [rootViewController performSelector:@selector(pushMyTripsController) withObject:nil afterDelay:1.0];
            [self.navigationController popToRootViewControllerAnimated:YES];

        });
        
    });

    
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
